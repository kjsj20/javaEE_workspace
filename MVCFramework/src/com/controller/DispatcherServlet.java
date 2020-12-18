/*
 * MVC패턴으로 개발하다보면, 늘어나는 컨트롤러에 대해 일일이 매핑과정을 진행해야 한다..
 * 이때 너무 많은 매핑은 관리하기가 까다롭다 따라서 유지보수성이 떨어진다..
 * 현실과 유사하게, 어플리케이션에서도 대형 업무 처리시 클라이언트의 요청을 곧바로 해당 컨트롤러
 * 처리하게 하지 않고, 중간에 메인 컨트롤러를 두고, 모든 요청을 이 메인 컨트롤러에서 처리하여
 * 적절한 하위 컨트롤러에게 전담시키는 방식을 이용한다..
 * 
 * 이 컨트롤러는 웹어플리케이션의 모든 ~~~ everything 요청을 1차적으로 받는다!!
 * */

package com.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DispatcherServlet extends HttpServlet{
	FileInputStream fis;
	Properties props;
	
	//init은 서블릿의 생명주기에서, 최초 접속자에 의해 톰켓이 인스턴스를 생성하며, 이와 동시에 초기화 메서드로
	//호출된다..
	public void init(ServletConfig config) throws ServletException {
		//getRealPath는 jsp의 내장객체 중 application에 대한 정보를 갖는 application 내장객체에서 지원함
		ServletContext context = config.getServletContext();
		String savePath = context.getRealPath(config.getInitParameter("contextConfigLocation"));
		try {		
			fis = new FileInputStream(savePath);
			props = new Properties();
			props.load(fis); //스트림과 프로퍼티스 연결
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doRequest(request, response);
	}
	
	//get or post상관없이, 모든 요청을 이 메서드에서 처리하자!!
	public void doRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		//1단계 : 요청을 받는다!!
		System.out.println("받아브려쓰");
		
		//2단계 : 요청을 분석하여, 알맞는 컨트롤러에게 요청을 전달
		//클라이언트가 원하는게 무엇인지 파악해보자..!
		//해답은 클라이언트 요청 자체에 있다.. 즉 요청시 사용된 uri가 곧 요청 내용이다!!
		String uri = request.getRequestURI();
		Controller controller = null;
		String className = null;
		
		
		//if문 대신, 프로퍼티스 객체를 이용하여 key값으로 메모리 올려질 컨트롤러의 이름을 value로 반환받자
		className = props.getProperty(uri);
//		className = request.getParameter("class");
		
		try {
			Class controllerClass = Class.forName(className);
			controller = (Controller) controllerClass.newInstance();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		
		
		controller.execute(request, response); //다형적으로 실행됨..(다형성)
		//5단계 : 클라이언트에게 알맞는 결과를 보여준다.
		//클라이언트로 하여금 지정한 url로 재접속을 유도하자!! 명령하자
		response.sendRedirect(controller.getViewPage());
	}
	
	public void destroy() {
		if(fis!=null) {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}			
		}
	}
}
