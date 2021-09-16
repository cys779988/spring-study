package com.spring;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.*;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.spring.board.model.BoardEntity;
import com.spring.board.model.CourseDto;
import com.spring.board.model.CourseEntity;
import com.spring.board.repository.BoardRepository;
import com.spring.board.repository.BoardRepositorySupport;
import com.spring.board.repository.CourseRepository;
import com.spring.common.util.AppUtil;

@ExtendWith(SpringExtension.class)
@SpringBootTest
//@DataJpaTest
//@AutoConfigureTestDatabase(replace = Replace.NONE)
public class BoardDataJpaTest {
	
	@Autowired
	private CourseRepository courseRepository;
	
	@Autowired
	private BoardRepositorySupport boardRepositorySupport;
	
	/*
	 * @AfterAll public void tearDown(){ boardRepository.deleteAllInBatch(); }
	 */
	/*
	 * @BeforeEach public void init() { queryFactory = new JPAQueryFactory(em); }
	 */
	
	@Test
	@Disabled
	public void querydsl_test() {
		/*
		 * String writer = "ys"; String title = "test0"; String content = "content0";
		 * boardRepository.save(BoardEntity.builder().title(title).writer(writer).
		 * content(content).build());
		 */
		String title = "test0";
		
		Long result = boardRepositorySupport.findCountByTitle(title);
		assertThat(result, is(Long.parseLong("4")));
	}
	
	@Test
	public void addTest() {
		List<CourseDto> contentsList = new ArrayList<>();
		for (int i = 0; i < 1; i++) {
			CourseDto dto =  CourseDto.builder()
					.id(Long.parseLong("2133"+i))
					.courseDiv("테스트")
					.name("테스트"+i)
					.type("Y")
					.playTime(12)
					.col1("param1")
					.col2("테스트")
					.col3("테스트")
					.col4("테스트")
					.col5("21314")
					.build();
			contentsList.add(dto);
			
			CourseEntity entity =  dto.toEntity();
			courseRepository.save(entity);
		}
	}
	
	@Test
	public void getTest() {
		List<CourseEntity> entity = courseRepository.findAll();
		assertThat(entity.size(), is(6));
	}
	/*@Test
	public void findCountByTitle() {
		Integer PAGE_POST_COUNT = 5;
		Integer pageNum = 1;
		Page<BoardEntity> page =  boardRepository.findByTitleContaining(PageRequest.of(pageNum-1, PAGE_POST_COUNT, Sort.by(Direction.ASC, "createdDate")), "0");
		System.out.println(page.toString());
	}*/
}
