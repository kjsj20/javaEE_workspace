/*
 * Jsp나 servlet 둘다 웹서버에서 해석 및 실행되어지므로, 글등록 요청을 처리할때는
 * 둘다 가능하다. 하지만, 현재 시점에서 jsp로 개발하지 않는 이유는 ?
 * 앞으로 jsp는 서블릿의 디자인적 처리시 단점을 보완하기 위해 개발된 기술이므로,
 * jsp는 주로 디자인 영역에서 사용된다..
 * */
package com.webapp1216.board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.webapp1216.board.model.Notice;
import com.webapp1216.board.model.NoticeDAO;

public class RegistServlet extends HttpServlet{
	NoticeDAO dao = new NoticeDAO();
	//글쓰기를 처리하는 서블릿이므로, 클라이언트의 요청이 post로 들어온다.. 따라서 doXXX형 중에서 doPost받자!!
	/*참고) doXXX형 메서드는 service() 메서드에 의해 호출된다, 이때 요청, 응답 객체가 전달*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*클라이언트의 파라미터 받기*/
		request.setCharacterEncoding("utf-8");
		
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		//빈즈 태그 사용가능?? .jsp 에서만 가능함..
		
		//vo에 담기
		Notice notice = new Notice();
		notice.setTitle(title);
		notice.setWriter(writer);
		notice.setContent(content);
		
		//클라이언트의 브라우저에 출력할 데이터를 응답객체 심어놓기
//		response.setContentType("text/html;charset=utf-8");
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print("제목은 : "+title+"<br>");
		out.print("작성자는 : "+writer+"<br>");
		out.print("내용은 : "+content+"<br>");
		
		int result = dao.insert(notice); //글 등록

		if(result == 0) {
			out.print("<script>");
			out.print("alert('등록실패 ...');");
			out.print("history.back();");
			out.print("</script>");
		} else {
			out.print("<script>");
			out.print("alert('등록성공...');");
			out.print("location.href='list.jsp';");
			out.print("</script>");
		}
	}
}
