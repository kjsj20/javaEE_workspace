package com.model2.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.controller.Controller;
import com.model2.notice.domain.Notice;
import com.model2.notice.model.NoticeDAO;

public class DetailController implements Controller{
	NoticeDAO noticeDAO = new NoticeDAO(); 
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Notice notice = noticeDAO.select(Integer.parseInt(req.getParameter("notice_id")));
		
		req.setAttribute("notice", notice);
	}

	@Override
	public String getResultView() {
		return "/view/notice/detail";
	}

	@Override
	public boolean isForward() {
		return true;
	}

}
