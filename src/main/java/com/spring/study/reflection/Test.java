package com.spring.study.reflection;

import java.lang.reflect.Method;
import java.lang.reflect.Field;
import java.lang.reflect.Constructor;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Class clazz = Child.class;
		Method[] method = clazz.getDeclaredMethods();
		
		Field[] field = clazz.getDeclaredFields();
		for (Field field2 : field) {
			System.out.println("Field name : " + field2.getName());
			System.out.println("Field Type : " + field2.getType());
		}
		for (Method method2 : method) {
			Class[] paramType = method2.getParameterTypes();
			Class[] exceptionType = method2.getExceptionTypes();
			
			for (Class exceptionType2 : exceptionType) {
				System.out.println("Method exceptionType : " + exceptionType2);
			}

			for (Class paramType2 : paramType) {
				System.out.println("Method parameterType : " + paramType2);
			}
			System.out.println("Method name : " + method2.getName());
		}
		System.out.println("Class name : " + clazz.getName());
	}

}
