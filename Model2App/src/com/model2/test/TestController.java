
/*
 *이 클래스는 하위 컨트롤럴로서 역할을 수행해야 하므로  
 * */
package com.model2.test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.controller.Controller;

public class TestController implements Controller{
	
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//3단계 : 
		String msg = "테스트입니다";
		
		//4단계 : 결과 저장
		HttpSession session = req.getSession();
		session.setAttribute("result", msg);
	}

	public String getResultView() {
		return "/view/test/result";
	}

}
