package com.spring.chat.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.chat.model.ChatRoom;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ChatService {
	private final ObjectMapper objectMapper;
	private Map<String, ChatRoom> chatRooms;
	
	@PostConstruct
	private void init() {
		chatRooms = new LinkedHashMap<>();
	}
	
	public List<ChatRoom> findAllRoom() {
		return new ArrayList<>(chatRooms.values());
	}
	
	public ChatRoom findRoomById(String roomId) {
		return chatRooms.get(roomId);
	}
	
	/*
	public ChatRoom createRoom(String name) {
		String randomId = UUID.randomUUID().toString();
		ChatRoom chatRoom = ChatRoom.builder()
				.roomId(randomId)
				.name(name)
				.build();
		chatRooms.put(randomId, chatRoom);
		return chatRoom;
	}
	
	public <T> void sendMessage(WebSocketSession session, T message) {
		try {
			session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}
	 */
}
