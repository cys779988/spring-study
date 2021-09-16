package com.spring.redis.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class UserViewDto {
	private String id;
	private String videoId;
	private String time;
}
