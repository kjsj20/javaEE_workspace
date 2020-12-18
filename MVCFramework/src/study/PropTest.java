/*
 * 자바의 컬렉션프레임웍의 객체 중 데이터가 key-value의 쌍으로 되어있는 형식을 전담하여
 * 처리할 수 있는객체를 Properties라 한다!!
 * 이 세상의 여러 형태의 데이터 형식 중 오직 key-value로 된  쌍만을 이해한다!!
 * */

package study;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropTest {
	public PropTest() {
		FileInputStream fis = null;
		Properties props = new Properties();
		try {
			fis = new FileInputStream("D:/javaEE_workspace/MVCFramework/WebContent/WEB-INF/mapping/mapping.properties");
			props.load(fis); //프로퍼티스 객체와 스트림 연결
			String value = props.getProperty("/movie.do");
			System.out.println(value);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		
	}
	
	public static void main(String[] args) {
		new PropTest();
	}
}
