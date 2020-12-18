/*
 * 모든 하위 컨트롤러가 반드시 구현해야할 메서드를 정의한다!!
 * */

package com.model2.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Controller {
	//알맞는 비즈니스 객체에 일 시키기 
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
	
	//어떤 뷰페이지를 보여줘야 할지 결정 
	//만일 하위 컨트롤러가 이업무를 처리하지 않으면, DispatcherServlet에서 if문으로 처리해야한다.
	
	public String getResultView();
	
	//요청을 끊어야할지, 유지해야할지를 결정하는 메서드
	public boolean isForward();
}
