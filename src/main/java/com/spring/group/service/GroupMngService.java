package com.spring.group.service;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.spring.course.repository.CourseRepository;
import com.spring.group.repository.GroupRepository;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class GroupMngService {
    private GroupRepository studyRepository;
	
	public void autoDivide(Map<String, Object> param) {

		Set<Map.Entry<String, Object>> set =  param.entrySet();
		Iterator<Map.Entry<String, Object>> it = set.iterator();
		
		String divCase = (String) it.next().getValue();

		List<String> cndList = (List<String>) it.next().getValue();
		Iterator<String> cndIt = cndList.iterator();
		
		List<Map<String, Object>> divClassStdntList = (List<Map<String, Object>>) it.next().getValue();
		
		while (cndIt.hasNext()) {
			String value = cndIt.next().toString();
			divClassStdntList.sort(new Comparator<Map<String, Object>>() {
				@Override
				public int compare(Map<String, Object> o1, Map<String, Object> o2) {
					return o1.get(value).toString().compareTo(o2.get(value).toString());
				}
			});
		}
		int mth = (int) it.next().getValue();
		int cls = (int) it.next().getValue();
		
		divideStdnt(divClassStdntList, mth, cls, divCase);
		
		studyRepository.saveAll(null);
	}
	
	private void divideStdnt(List<Map<String, Object>> divClassStdntList, int mth, int cls, String divCase) {
		
		int maxNmpr = divClassStdntList.size() / cls;
		int outNmpr = divClassStdntList.size() % cls;
		
		int [] nmprArr = new int[cls];
		
		for (int i = 0; i < nmprArr.length; i++) {
			nmprArr[i] = maxNmpr;
			if(i < outNmpr) {
				nmprArr[i]++;
			}
		}
		int i = 0;
		if(mth > 0) {
			for(Map<String, Object> map : divClassStdntList) {
				if(nmprArr[i]==0) {
					++i;
				}
				map.put(divCase, i+1);
				nmprArr[i]--;
			}
		} else {
			for(Map<String,Object> map : divClassStdntList) {
				if(i == cls) {
					i = 0;
				}
				map.put(divCase, i+1);
				nmprArr[i]--;
				i++;
			}
		}
	}

	@SuppressWarnings("rawtypes")
	public static Object convertMapToObject(Map map, Object objClass) {
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null;
		Iterator itr = map.keySet().iterator();
		while (itr.hasNext()) {
			keyAttribute = (String) itr.next();
			methodString = setMethodString + keyAttribute.substring(0, 1).toUpperCase() + keyAttribute.substring(1);
			try {
				Method[] methods = objClass.getClass().getDeclaredMethods();
				for (int i = 0; i <= methods.length - 1; i++) {
					if (methodString.equals(methods[i].getName())) {
						System.out.println("invoke : " + methodString);
						methods[i].invoke(objClass, map.get(keyAttribute));
					}
				}
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return objClass;
	}

}
