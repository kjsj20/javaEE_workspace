package com.model2.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.controller.Controller;
import com.model2.domain.Board;
import com.model2.model.BoardDAO;

public class RegistController implements Controller{
	BoardDAO boardDAO = new BoardDAO();
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String title = req.getParameter("title");
		String writer = req.getParameter("writer");
		String content = req.getParameter("content");
		Board board = new Board();
		int result = 0; 
		board.setTitle(title);
		board.setWriter(writer);
		board.setContent(content);
		result = boardDAO.insert(board);
		
		//4단계 : 저장할것이 없다..
	}

	public String getResultView() {
		return "/view/board/regist";
	}

	public boolean isForward() {
		return false;
	}
	
}
