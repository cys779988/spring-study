package com.spring.board.service;

import lombok.AllArgsConstructor;

import org.springframework.stereotype.Service;

import com.spring.board.model.CourseDto;
import com.spring.board.model.CourseEntity;
import com.spring.board.repository.CourseRepository;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@Service
public class CourseService {
    private CourseRepository courseRepository;
    
    @Transactional
    public List<CourseDto> getCourseList() {
    	List<CourseEntity> courseEntities = courseRepository.findAll();
        List<CourseDto> courseDtoList = new ArrayList<>();
        int rowKey = 0;
        for ( CourseEntity courseEntity : courseEntities) {
        	courseDtoList.add(this.convertEntityToDto(courseEntity, rowKey++));
        }

        return courseDtoList;
    }
    
    @Transactional
    public CourseDto getPost(Long id) {
        Optional<CourseEntity> entityWrapper = courseRepository.findById(id);
        CourseEntity courseEntity = entityWrapper.get();

        CourseDto courseDto = CourseDto.builder()
                .courseDiv(courseEntity.getCourseDiv())
                .name(courseEntity.getName())
                .type(courseEntity.getType())
                .playTime(courseEntity.getPlayTime())
                .col1(courseEntity.getCol1())
                .col2(courseEntity.getCol2())
                .col3(courseEntity.getCol3())
                .col4(courseEntity.getCol4())
                .col5(courseEntity.getCol5())
                .build();

        return courseDto;
    }

    @Transactional
    public Long add(CourseDto courseDto) {
        return courseRepository.save(courseDto.toEntity()).getId();
    }

    @Transactional
    public void delete(Long id) {
    	courseRepository.deleteById(id);
    }
    
    private CourseDto convertEntityToDto(CourseEntity courseEntity, int rowKey) {
        return CourseDto.builder()
                .courseDiv(courseEntity.getCourseDiv())
                .name(courseEntity.getName())
                .type(courseEntity.getType())
                .playTime(courseEntity.getPlayTime())
                .col1(courseEntity.getCol1())
                .col2(courseEntity.getCol2())
                .col3(courseEntity.getCol3())
                .col4(courseEntity.getCol4())
                .col5(courseEntity.getCol5())
                .rowKey(rowKey)
                .build();
    }

}
