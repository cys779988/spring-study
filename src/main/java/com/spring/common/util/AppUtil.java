package com.spring.common.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AppUtil {
	
	public Map<String, Object> convertGridData(List<?> param, Map<String, Object> page) {
		Map<String, Object> readData = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		
		data.put("contents", param);
		data.put("pagination", page);

		readData.put("result", "true");
		readData.put("data", data);
		
		return readData;
	}
}
