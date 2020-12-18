/*
 * 웹상의 모든 클라이언트의 요청을 받고 , 응답을 전담하는 컨트롤러 정의
 * */
package com.model2.controller;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class DispatcherServlet extends HttpServlet{
	FileReader fr; //컨트롤러 매핑 설정파일을 읽기위한 스트림
	JSONObject controllerMap,viewKey; //컨트롤러, view의 정보들이 들어있는 맵
	
	public void init(ServletConfig config) throws ServletException {
		String contextConfigLocation = config.getInitParameter("contextConfigLocation");
		String realPath = config.getServletContext().getRealPath(contextConfigLocation);
		try {
			fr = new FileReader(realPath);
			JSONParser jsonParser = new JSONParser();
			
			//파싱
			JSONObject json = (JSONObject)jsonParser.parse(fr);
			
			//데이터에 접근
			controllerMap = (JSONObject) json.get("controller");
			viewKey = (JSONObject) json.get("view");
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doReqeust(req,resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doReqeust(req,resp);
	}
	
	public void doReqeust(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		//2단계: 요청을 분석한다.
		String uri = req.getRequestURI(); //클라이언트가 요청시 사용한 uri자체가 요청의 구분값으로 사용될 수 있다.
		//if문을 대신할 구조화된 데이터를 선택하자!!(xml, json, properties)
		String controllerName = (String) controllerMap.get(uri);
		//동생 하위 컨트롤러의 이름을 알았으니, 인스턴스를 만들고, execute(), getResultView호출()
		Class controllerClass = null;
		Controller controller = null;
		try {
			controllerClass = Class.forName(controllerName);
			controller = (Controller) controllerClass.newInstance();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		
		controller.execute(req, resp); //3단계 업무
		
		//하위 컨트롤러로부터 넘겨받은 뷰에 대한 정보를 이용하여 클라이언트에게 알맞는 뷰를 보여주자
		String resultKey = controller.getResultView();
		//동생 컨트롤러로부터 넘겨받은 키값을 이용하여 실제 페이지를 검색하고, 그 결과를   
		String viewPage=(String) viewKey.get(resultKey);
		
		//응답시 sendRedirect로 처리해야 할 경우가 있고, 글작성 후 리스트, 전혀 다른 페이지로 재접속을 시도 
		if(controller.isForward()) {
			//때로는 forwarding 처리해야 할 경우가 있다.. 데이터를 유지하고싶을때..
			RequestDispatcher dis = req.getRequestDispatcher(viewPage);
			dis.forward(req, resp);			
		} else {
			resp.sendRedirect(viewPage);			
		}
	}
	
	public void destroy() {
		if(fr != null) {
			try {
				fr.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
