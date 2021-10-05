package com.spring.redis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.stereotype.Service;

import com.spring.chat.model.ChatMessage;

@Service
public class RedisPublisher {
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	
	public void publish(ChannelTopic topic, ChatMessage message) {
		redisTemplate.convertAndSend(topic.getTopic(), message);
	}
}
