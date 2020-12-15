<%@page import="board.model.MybatisBoardDAO"%>
<%@page import="common.file.FileManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file = "/inc/lib.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	String board_id = request.getParameter("board_id");
	String filename = request.getParameter("filename");
	MybatisBoardDAO dao = new MybatisBoardDAO();
	String path = application.getRealPath("/data");
	
	if(FileManager.deleteFile(path + "/" + filename)){
		int result = dao.delete(Integer.parseInt(board_id));
		
		if(result == 0){
			out.print(getMsgBack("삭제실패"));
		} else {
			out.print(getMsgURL("삭제성공", "list.jsp"));
		}
		
	} else {
		out.print(getMsgBack("파일을 삭제할 수 없습니다."));
	}
%>