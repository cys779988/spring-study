package com.spring.security.controller;

import java.util.Map;

import javax.servlet.http.HttpSessionListener;
import javax.validation.Valid;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.common.config.LoginUser;
import com.spring.security.model.SessionUser;
import com.spring.security.model.UserDto;
import com.spring.security.model.UserInformation;
import com.spring.security.service.UserService;

import lombok.AllArgsConstructor;



@Controller
@AllArgsConstructor
public class UserController implements HttpSessionListener{
	private UserService userService;

	@GetMapping("/")
	public String index(Model model, @LoginUser SessionUser user) {
		
		if(user != null) {
			model.addAttribute("userName", user.getName());
		}
		return "/board/list";
	}

	@ResponseBody
	@GetMapping("/api/user")
	public Object getUserInfo() {
		return SecurityContextHolder.getContext().getAuthentication();
	}
	
	@GetMapping("/user/signup")
	public String dispSignup(Model model) {
		UserDto userDto = new UserDto();
		model.addAttribute("userDto", userDto);
		return "/signup";
	}

	@ResponseBody
	@PostMapping("/user/signup")
	public Long execSignup(@Valid UserDto userDto, Errors errors, Model model) {
		if(errors.hasErrors()) {
			model.addAttribute("userDto", userDto);
			
			Map<String, String> validatorResult = userService.validateHandling(errors);
			for (String key : validatorResult.keySet()) {
				model.addAttribute(key, validatorResult.get(key));
			}
			
			//return "/signup";
			return Long.parseLong("999");
		}
		
		//userService.joinUser(userDto);
		return userService.joinUser(userDto);
	}

	@GetMapping("/user/login")
	public String dispLogin() {
		ThreadLocal<UserInformation> local = new ThreadLocal<>();
		UserInformation user = new UserInformation();
		local.set(user);
		UserInformation user2 = new UserInformation();
		user2 = local.get();
		return "/login";
	}

	@GetMapping("/user/logout/result")
	public String dispLogout() {
		return "/logout";
	}

	@GetMapping("/user/denied")
	public String dispDenied() {
		return "/denied";
	}

	@GetMapping("/user/info")
	public String dispMyInfo() {
		return "/myinfo";
	}

	@GetMapping("/admin")
	public String dispAdmin() {
		return "/admin";
	}
}
