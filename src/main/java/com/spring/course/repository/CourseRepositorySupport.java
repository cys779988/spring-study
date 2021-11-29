package com.spring.course.repository;

import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;
import org.springframework.stereotype.Repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import com.querydsl.jpa.impl.JPAUpdateClause;
import com.spring.course.model.CourseEntity;
import com.spring.course.model.QCourseEntity;

@Repository
public class CourseRepositorySupport extends QuerydslRepositorySupport {
	
	private final JPAQueryFactory queryFactory;
	
	public CourseRepositorySupport(JPAQueryFactory queryFactory) {
		super(CourseEntity.class);
		this.queryFactory = queryFactory;
	}
	
	
	public Long findCountByTitle(String param) {
		return queryFactory
				.selectFrom(QCourseEntity.courseEntity)
				.where(QCourseEntity.courseEntity.title.like(param+"%"))
				.fetchCount();
	}
	
	public void updateCourse(CourseEntity param) {
		queryFactory.update(QCourseEntity.courseEntity)
					.set(QCourseEntity.courseEntity.title, param.getTitle())
					.set(QCourseEntity.courseEntity.category, param.getCategory())
					.set(QCourseEntity.courseEntity.divclsNo, param.getDivclsNo())
					.set(QCourseEntity.courseEntity.maxNum, param.getMaxNum())
					.set(QCourseEntity.courseEntity.content, param.getContent())
					.set(QCourseEntity.courseEntity.node, param.getNode())
					.set(QCourseEntity.courseEntity.edge, param.getEdge())
					.where(QCourseEntity.courseEntity.id.eq(param.getId()))
					.execute();
	}
}
