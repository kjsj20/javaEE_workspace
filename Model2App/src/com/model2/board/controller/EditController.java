package com.model2.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.controller.Controller;
import com.model2.domain.Board;
import com.model2.model.BoardDAO;

public class EditController implements Controller{
	BoardDAO boardDAO = new BoardDAO();
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String board_id = req.getParameter("board_id");
		String title = req.getParameter("title");
		String writer = req.getParameter("writer");
		String content = req.getParameter("content");
		
		Board board = new Board();
		board.setBoard_id(Integer.parseInt(board_id));
		board.setTitle(title);
		board.setWriter(writer);
		board.setContent(content);
		
		//3단계 : 수정 처리 
		int result = boardDAO.update(board);
		
		req.setAttribute("result", result);
		req.setAttribute("board", board);
	}

	public String getResultView() {
		return "/view/board/edit";
	}

	public boolean isForward() {
		return true;
	}
	

}
