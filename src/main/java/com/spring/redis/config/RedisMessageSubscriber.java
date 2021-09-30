package com.spring.redis.config;

import java.util.StringTokenizer;

import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RedisMessageSubscriber implements MessageListener {

	@Override
	public void onMessage(Message message, byte[] pattern) {
		// TODO Auto-generated method stub
		log.debug("subscriber:message[{}]", message.toString());
		StringTokenizer st = new StringTokenizer(message.toString().replaceAll("\"",""),"/");
		String value = st.nextToken();
		System.out.println(value);
	}
}
