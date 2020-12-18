/*
 * 자바에서클래스의 인스턴스를 생성하는 방법에는 new 연산자만 있는것은 아니다!!
 * */
package study;

import java.lang.reflect.Method;

public class instanceTest {
	public static void main(String[] args) {
		//Dog 클래스를 new연산자 쓰지 않고 올려보자
		try {
			Class dogClass = Class.forName("study.Dog"); //클래스 로드
			System.out.println("로드 성공");
			Dog dog =  (Dog) dogClass.newInstance();
			System.out.println(dog.getName());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("로드 성공");
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
