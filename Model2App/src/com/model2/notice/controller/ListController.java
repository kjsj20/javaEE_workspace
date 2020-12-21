/*
 * 공지게시판의 목록 요청을 처리하는 하위 컨트롤러 
 * */
package com.model2.notice.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.controller.Controller;
import com.model2.model.NoticeDAO;

public class ListController implements Controller{
	NoticeDAO noticeDAO = new NoticeDAO();
	
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//3단계 : 알맞는 로직 객체에게 일시킨다.
		List list = noticeDAO.selectAll();
		//4단계 : 클라이언트가 봐야할 결과가 있다면, 결과 저장(그래야 DispatcherServlet컨트롤러가 사용할 수 있으니..)
		HttpSession session = req.getSession();
		req.setAttribute("noticeList", list);
	}

	public String getResultView() {
		return "/view/notice/list";
	}

	@Override
	public boolean isForward() {
		// TODO Auto-generated method stub
		return true;
	}
	
}
