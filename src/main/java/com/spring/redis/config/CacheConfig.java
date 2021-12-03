package com.spring.redis.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import com.fasterxml.jackson.databind.ObjectMapper;

@Configuration
@EnableCaching
public class CacheConfig {
	
	@Autowired
	ObjectMapper objectMapper;
	
	@Bean
	public CacheManager redisCacheManager(@Qualifier("redisCacheConnectionFactory") RedisConnectionFactory redisConnectionFactory) {
		RedisCacheConfiguration redisCacheConfiguration = RedisCacheConfiguration.defaultCacheConfig()
															.serializeKeysWith(RedisSerializationContext
																				.SerializationPair
																				.fromSerializer(new StringRedisSerializer()))
															.serializeValuesWith(RedisSerializationContext
																				.SerializationPair
																				.fromSerializer(new GenericJackson2JsonRedisSerializer()));
		
		RedisCacheManager redisCacheManager = RedisCacheManager.RedisCacheManagerBuilder
															.fromConnectionFactory(redisConnectionFactory)
															.cacheDefaults(redisCacheConfiguration)
															.build();
		return redisCacheManager;
	}
}
