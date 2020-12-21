/*
 * 댓글 목록 요청을 처리하는 컨트롤러
 * */
package com.model2.comment.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.controller.Controller;
import com.model2.model.CommentDAO;

public class ListController implements Controller{
	CommentDAO commentDAO = new CommentDAO(); 
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String board_id = req.getParameter("board_id");
		List list = commentDAO.selectAll(Integer.parseInt(board_id));
		req.setAttribute("commentList", list);
	}

	public String getResultView() {
		return "/view/comment/list";
	}

	public boolean isForward() {
		return true;
	}

}
