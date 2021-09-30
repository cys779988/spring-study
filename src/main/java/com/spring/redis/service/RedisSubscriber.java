package com.spring.redis.service;

import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.redis.model.MessageDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class RedisSubscriber implements MessageListener{

	private final ObjectMapper objectMapper;
	private final RedisTemplate redisTemplate;
	
	@Override
	public void onMessage(Message message, byte[] pattern) {
		// TODO Auto-generated method stub
		try {
			String body = (String) redisTemplate.getStringSerializer().deserialize(message.getBody());
			MessageDto roomMessage = objectMapper.readValue(body, MessageDto.class);
			log.info("Room - Message : {}", roomMessage.toString());
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e.getMessage());
		}
	}
}
