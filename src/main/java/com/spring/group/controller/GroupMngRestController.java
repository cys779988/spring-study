package com.spring.group.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.group.service.GroupMngService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
@RequestMapping("/api/group/*")
public class GroupMngRestController {
	
	GroupMngService groupMngService;
	
	/*
	 * @GetMapping("/user") public ResponseEntity getUser(@RequestBody
	 * Map<String, Object> param) { List<UserDto> result =
	 * studyMngService.getUser(param); Long totalCount =
	 * studyMngService.getUserCount(); Map<String, Object> pagination = new
	 * HashMap<>(); pagination.put("page", param.getPage()); param.calcPage();
	 * 
	 * pagination.put("totalCount", totalCount); GridUtil gridUtil = new
	 * GridUtil(result, pagination); return ResponseEntity.ok(gridUtil.getData()); }
	 * 
	 * @PostMapping("/autoDivide") public ResponseEntity autoDivide(@RequestBody
	 * Map<String, Object> param) { studyMngService.autoDivide(param); return
	 * ResponseEntity.ok(""); }
	 * 
	 * @PostMapping("/resetDivide") public ResponseEntity resetDivide(@RequestBody
	 * Map<String, Object> param) { studyMngService.resetDivide(param); return
	 * ResponseEntity.ok(""); }
	 */
}
