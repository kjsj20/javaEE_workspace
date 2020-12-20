package com.model2.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.controller.Controller;
import com.model2.notice.domain.Notice;
import com.model2.notice.model.NoticeDAO;

public class EditController implements Controller{
	NoticeDAO noticeDAO = new NoticeDAO();
	int result = 0;
	
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Notice notice = new Notice();
		String title = req.getParameter("title");
		String writer = req.getParameter("writer");
		String content = req.getParameter("content");
		int notice_id = Integer.parseInt(req.getParameter("notice_id"));
		
		notice.setTitle(title);
		notice.setWriter(writer);
		notice.setContent(content);
		notice.setNotice_id(notice_id);
		
		result = noticeDAO.update(notice);
	}

	public String getResultView() {
		if(result == 0) {
			return "/view/error/delErr";
		} else {
			return "/view/notice/edit";
		}
	}

	public boolean isForward() {
		return true;
	}

}
