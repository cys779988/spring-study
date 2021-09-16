package com.spring.redis.controller;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.redis.model.RedisDto;

@RestController
@RequestMapping("/redis/*")
public class RedisController {
	private final RedisTemplate<String, Object> redisTemplate;
	
	public RedisController(RedisTemplate<String, Object> redisTemplate) {
		// TODO Auto-generated constructor stub
		this.redisTemplate = redisTemplate;
	}
	
	@PostMapping(value="/", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> addRedisKey(@RequestBody RedisDto redisDto) {
		ValueOperations<String, Object> vop = redisTemplate.opsForValue();
		vop.set(redisDto.getKey(), redisDto.getValue());
		return ResponseEntity.ok(null);
	}
	
	@GetMapping("/{key}")
	public ResponseEntity<?> getRedisKey(@PathVariable String key) {
		ValueOperations<String, Object> vop = redisTemplate.opsForValue();
		
		return ResponseEntity.ok(vop.get(key));
	}
}
