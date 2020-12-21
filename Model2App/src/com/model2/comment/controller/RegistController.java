/*
 * 댓글 등록요청을 처리하는 컨트롤러!
 * */
package com.model2.comment.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.controller.Controller;
import com.model2.domain.Comment;
import com.model2.model.CommentDAO;

public class RegistController implements Controller{
	CommentDAO commentDAO = new CommentDAO();
	//댓글의 등록은 비동기 요청으로 들어오기 때문에, 응답정보는 페이지를 보여주는게 아니라, 
	//데이터를 전송해야함!!
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String msg = req.getParameter("msg");
		String author = req.getParameter("author");
		String board_id = req.getParameter("board_id");
		
		//vo에 담기
		Comment comment = new Comment();
		comment.setAuthor(author);
		comment.setMsg(msg);
		comment.setBoard_id(Integer.parseInt(board_id));
		
		//등록 메서드 호출!!
		int result = commentDAO.insert(comment);
		
		//4단계 : dml 수행결과를 저장하겠다.
		req.setAttribute("result", result);
	}

	public String getResultView() {
		return "/view/comment/regist";
	}

	public boolean isForward() {
		// TODO Auto-generated method stub
		return true;
	}

}
