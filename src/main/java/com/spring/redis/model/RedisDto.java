package com.spring.redis.model;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class RedisDto {
	private String key;
	private UserViewDto value;

	@Builder
	public RedisDto(String key, UserViewDto value) {
		this.key = key;
		this.value = value;
	}
}
