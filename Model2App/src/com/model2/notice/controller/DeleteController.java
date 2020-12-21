package com.model2.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.controller.Controller;
import com.model2.model.NoticeDAO;

public class DeleteController implements Controller{
	NoticeDAO noticeDAO = new NoticeDAO();
	int result = 0;
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String notice_id = req.getParameter("notice_id"); 
		result = noticeDAO.delete(Integer.parseInt(notice_id));
	}

	public String getResultView() {
		if(result == 0) {
			System.out.println(result);
			return "/view/error/delErr";
		} else {
			return "/view/notice/regist";			
		}
	}

	public boolean isForward() {
		return false;
	}

}
