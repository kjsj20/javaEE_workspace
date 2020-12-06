<%@page import="board.model.Notice"%>
<%@page import="board.model.NoticeDAO"%>
<%@ page contentType = "text/html;charset=utf-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "db.DBManager"%>
<%@ include file = "/inc/lib.jsp"%>
<%
/*
수정 요청을 처리하는 jsp... 수정후 상세보기 페이지로 전환할 것이므로,
디자인이 필요없고 오직 db 로직만 있으면 됨 ..
*/
	DBManager dbManager = new DBManager();
	request.setCharacterEncoding("utf-8"); //전송 파라미터들에 대한 인코딩 처리!!
	String author = request.getParameter("author");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String notice_id = request.getParameter("notice_id");
	
	Notice notice = new Notice();
	notice.setAuthor(author);
	notice.setTitle(title);
	notice.setContent(content);
	notice.setNotice_id(Integer.parseInt(notice_id));
	
	NoticeDAO noticeDAO = new NoticeDAO();
	
	int result = noticeDAO.update(notice);
	
	if(result == 0){
		out.print(getMsgBack("수정실패"));
	} else {
		out.print(getMsgURL("수정성공","board/detail.jsp?notice_id="+notice_id));
	}
%>