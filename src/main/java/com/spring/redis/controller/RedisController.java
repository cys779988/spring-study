package com.spring.redis.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.chat.model.ChatMessage;
import com.spring.redis.service.RedisPublisher;
import com.spring.redis.service.RedisSubscriber;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/redis/*")
public class RedisController {
	private final RedisTemplate<String, Object> redisTemplate;
	
	private final RedisPublisher redisPublisher;

	private final RedisMessageListenerContainer redisMessageListener;
	
	private final RedisSubscriber redisSubscriber;
	
	private Map<String, ChannelTopic> channels;
	
	/*
	 * public RedisController(RedisTemplate<String, Object> redisTemplate) { // TODO
	 * Auto-generated constructor stub this.redisTemplate = redisTemplate; }
	 */

	@PostConstruct
	public void init() {
		channels = new HashMap<>();
	}
	
	@GetMapping(value="/room")
	public Set<String> findAllRoom() {
		return channels.keySet();
	}
	
	/*
	@PutMapping(value="/room/{roomId}")
	public void createRoom(@PathVariable String roomId) {
		ChannelTopic channel = new ChannelTopic(roomId);
		redisMessageListener.addMessageListener(redisSubscriber, channel);
		channels.put(roomId, channel);
	}
	*/
	@PostMapping(value="/room/{roomId}")
	public void pushMessage(@PathVariable String roomId, @RequestParam String sender, @RequestParam String message) {
		ChannelTopic channel = channels.get(roomId);
		ChatMessage chatMessage = new ChatMessage();
		chatMessage.setRoomId(roomId);
		chatMessage.setSender(sender);
		chatMessage.setMessage(message);
		redisPublisher.publish(channel, chatMessage);
	}
	
	@PostMapping(value="/", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> addRedisKey(@RequestBody ChatMessage message) {
		ValueOperations<String, Object> vop = redisTemplate.opsForValue();
		vop.set(message.getSender(), message.getMessage());
		return ResponseEntity.ok(null);
	}
	
	@GetMapping(value="/{key}")
	public ResponseEntity<?> getRedisKey(@PathVariable String key) {
		ValueOperations<String, Object> vop = redisTemplate.opsForValue();
		return ResponseEntity.ok(vop.get(key));
	}
}
