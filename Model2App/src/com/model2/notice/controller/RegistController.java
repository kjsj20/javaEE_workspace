package com.model2.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.controller.Controller;
import com.model2.notice.domain.Notice;
import com.model2.notice.model.NoticeDAO;

public class RegistController implements Controller{
	NoticeDAO noticeDAO = new NoticeDAO();
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//3단계 : 알맞는 로직 객체에게 일시킨다.
		//파라미터 vo에 담기
		Notice notice = new Notice();
		String title = req.getParameter("title");
		String writer = req.getParameter("writer");
		String content = req.getParameter("content");
		notice.setTitle(title);
		notice.setWriter(writer);
		notice.setContent(content);
		
		int result = noticeDAO.insert(notice);
	}

	@Override
	public String getResultView() {
		return "/view/notice/regist";
	}

	@Override
	public boolean isForward() {
		return false;
	}

}
