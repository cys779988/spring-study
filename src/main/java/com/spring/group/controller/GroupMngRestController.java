package com.spring.group.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.group.model.GroupDto;
import com.spring.group.service.GroupMngService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
@RequestMapping("/api/group/*")
@SuppressWarnings("rawtypes")
public class GroupMngRestController {

	GroupMngService groupMngService;
	
	ObjectMapper objectMapper;
	
	@PostMapping("/apply/{no}")
	public ResponseEntity apply(@PathVariable("no") Long no) {
		groupMngService.apply(no);
		return ResponseEntity.ok("");
	}
	
	@GetMapping("/{no}")
	public ResponseEntity getUsers(@PathVariable("no") Long no) {
		return ResponseEntity.ok(groupMngService.getUsers(no));
	}

	@PostMapping("/autoDivide")
	public ResponseEntity autoDivide(@RequestBody Map<String, Object> param) {
		groupMngService.autoDivide(param);
		return ResponseEntity.ok("");
	}

	@PostMapping("/resetDivide/{no}")
	public ResponseEntity resetDivide(@PathVariable("no") Long no) {
		groupMngService.resetDivide(no);
		return ResponseEntity.ok("");
	}
	
	@PostMapping("/updateDivide")
	public ResponseEntity updateDivide(@RequestBody List<GroupDto> groupDto) {
		groupMngService.updateDivide(groupDto);
		return ResponseEntity.ok("");
	}

}
