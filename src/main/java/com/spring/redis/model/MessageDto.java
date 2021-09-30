package com.spring.redis.model;

import java.io.Serializable;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MessageDto implements Serializable{
	
	private static final long serialVersionUID = -8634912491716287346L;
	
	private String roomId;
	private String name;
	private String message;

	@Builder
	public MessageDto(String roomId, String name, String message) {
		this.roomId = roomId;
		this.name = name;
		this.message = message;
	}
}
