package com.spring.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.board.model.CourseDto;
import com.spring.board.service.CourseService;
import com.spring.common.util.AppUtil;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
@RequestMapping("/api/course/*")
@SuppressWarnings("rawtypes")
public class CourseRestController {
	
	CourseService courseService;

	@GetMapping(value = "/get")
	public ResponseEntity getData(@RequestParam(value="param", required = false) String param) {
		List<CourseDto> contentsList =  courseService.getCourseList();
		AppUtil appUtil = new AppUtil();
		
		Map<String, Object> result = appUtil.convertGridData(contentsList);
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping(value = "/post", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity postData(@RequestBody CourseDto param) {
		courseService.add(param);
		return ResponseEntity.ok(null);
	}

	@PutMapping(value = "/put", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity putData(@RequestBody CourseDto param) {
		courseService.add(param);
		return ResponseEntity.ok(null);
	}
	
	@DeleteMapping(value = "/delete/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity deleteData(@PathVariable(value = "id") Long id) {
		courseService.delete(id);
		return ResponseEntity.ok(null);
	}
}
