package com.spring.redis.service;

import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.chat.model.ChatMessage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class RedisSubscriber implements MessageListener{

	private final ObjectMapper objectMapper;
	private final RedisTemplate redisTemplate;
	private final SimpMessageSendingOperations messagingTemplate;
	
	
	// Redis에서 메시지가 publish 되면 대기하고 있던 onMessage가 해당 메시지를 받아 처리
	
	@Override
	public void onMessage(Message message, byte[] pattern) {
		// TODO Auto-generated method stub
		try {
			String body = (String) redisTemplate.getStringSerializer().deserialize(message.getBody());
			ChatMessage roomMessage = objectMapper.readValue(body, ChatMessage.class);
			messagingTemplate.convertAndSend("/sub/chat/room/" + roomMessage.getRoomId(), roomMessage);
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e.getMessage());
		}
	}
}
