package com.spring.course.service;

import lombok.AllArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.spring.common.util.PageVO;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.common.util.AppUtil;
import com.spring.course.model.CategoryEntity;
import com.spring.course.model.CourseDto;
import com.spring.course.model.CourseEntity;
import com.spring.course.repository.CategoryRepository;
import com.spring.course.repository.CourseRepository;
import com.spring.course.repository.CourseRepositorySupport;
import com.spring.security.repository.UserRepository;

import javax.transaction.Transactional;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@Service
public class CourseService {
	private UserRepository userRepository;
    private CourseRepository courseRepository;
    private CategoryRepository categoryRepository;
    private ObjectMapper objectMapper;
    private CourseRepositorySupport courseRepositorySupport;
    
    @Transactional
    public List<CourseDto> getCourses(PageVO pageVO, Long id) {
    	Page<CourseEntity> page;
    	if(id == null) {
    		page = courseRepository.findAll(PageRequest.of(pageVO.getPage(), pageVO.getPerPage(), Sort.by(Direction.ASC, "createdDate")));
    	} else {
    		page = courseRepository.findByCategoryId(PageRequest.of(pageVO.getPage(), pageVO.getPerPage(), Sort.by(Direction.ASC, "createdDate")), id);
    	}
        List<CourseEntity> courseEntities = page.getContent();
        List<CourseDto> courseDtoList = new ArrayList<>();

        for ( CourseEntity courseEntity : courseEntities) {
        	courseDtoList.add(this.convertEntityToDto(courseEntity));
        }

        return courseDtoList;
    }
    
    @Transactional
    public Long getCourseCount() {
        return courseRepository.count();
    }

	public List<CategoryEntity> getCategories() {
		return categoryRepository.findAll();
	}

    @Transactional
    public CourseDto getCourse(Long id) {
    	Optional<CourseEntity> entityWrapper = courseRepository.findById(id);
    	CourseDto courseDto = new CourseDto();
        if(entityWrapper.isPresent()) {
        	CourseEntity courseEntity = entityWrapper.get();
        	courseDto = convertEntityToDto(courseEntity);
        }
        return courseDto;
    }

    
    @Transactional
    public void addCourse(CourseDto courseDto) {
    	CourseEntity entity;
		try {
			entity = courseDto.toEntity();
			entity.setRegistrant(userRepository.findById(AppUtil.getUser()).get());
			courseRepository.save(entity);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
    }
    
    @Transactional
    public void updateCourse(CourseDto courseDto) {
    	CourseEntity entity;
    	try {
    		entity = courseDto.toEntity();
    		entity.setRegistrant(userRepository.findById(AppUtil.getUser()).get());
    		courseRepositorySupport.updateCourse(entity);
    	} catch (JsonProcessingException e) {
    		e.printStackTrace();
    	}
    }

    @Transactional
    public void deleteCourse(Long id) {
    	courseRepository.deleteById(id);
    }
	
    private CourseDto convertEntityToDto(CourseEntity courseEntity) {
        return CourseDto.builder()
        		.id(courseEntity.getId())
        		.registrant(courseEntity.getRegistrant().getEmail())
        		.title(courseEntity.getTitle())
                .content(courseEntity.getContent())
                .divclsNo(courseEntity.getDivclsNo())
                .category(courseEntity.getCategory().getId())
                .categoryName(courseEntity.getCategory().getName())
                .maxNum(courseEntity.getMaxNum())
                .curNum(courseEntity.getCurNum())
                .node(jsonToList(courseEntity.getNode()))
                .edge(jsonToList(courseEntity.getEdge()))
                .createdDate(courseEntity.getCreatedDate())
                .build();
    }

    private List<Object> jsonToList(String data) {
    	List<Object> readValue = new ArrayList<Object>();
    	try {
    		readValue = objectMapper.readValue(data, new TypeReference<List<Object>>() {
			});
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return readValue;
    }
}
