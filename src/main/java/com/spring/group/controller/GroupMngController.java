package com.spring.group.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.group.service.GroupMngService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/group/*")
public class GroupMngController {

	private GroupMngService studyMngService;
	
	
	@GetMapping("/")
	public String groupMngView() {
		return "group/groupMng";
	}
	
}
