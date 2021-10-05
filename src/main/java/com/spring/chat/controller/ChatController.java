package com.spring.chat.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.chat.model.ChatMessage;
import com.spring.chat.repository.ChatRoomRepository;
import com.spring.redis.service.RedisPublisher;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class ChatController {
	
	private final RedisPublisher redisPublisher;
	private final ChatRoomRepository chatRoomRepository;
	
	@MessageMapping("/chat/message")
	public void message(ChatMessage message) {
		if(ChatMessage.MessageType.ENTER.equals(message.getType())) {
			chatRoomRepository.enterChatRoom(message.getRoomId());
			message.setMessage(message.getSender() + "님이 입장하셨습니다.");
		}
		redisPublisher.publish(chatRoomRepository.getTopic(message.getRoomId()), message);
	}
}
