<%@page import="common.file.FileManager"%>
<%@page import="board.model.BoardDAO"%>
<%@page import="board.model.Board"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file = "/inc/lib.jsp" %>
<%
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	String realPath = application.getRealPath("/data");
	
	factory.setRepository(new File(realPath));
	factory.setSizeThreshold(2*1024*1024);
	factory.setDefaultCharset("utf-8");
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	List<FileItem> items = upload.parseRequest(request);
	
	Board board = new Board();
	boolean flag = false;
	BoardDAO dao = new BoardDAO();
	
	for(int i = 0; i < items.size(); i++){
		FileItem item = items.get(i);
		if(item.isFormField()){
			if(item.getFieldName().equals("board_id")){
				board.setBoard_id(Integer.parseInt(item.getString()));
			} else if(item.getFieldName().equals("title")){
				board.setTitle(item.getString());
			} else if(item.getFieldName().equals("writer")){
				board.setWriter(item.getString());
			} else if(item.getFieldName().equals("content")){
				board.setContent(item.getString());
			}
		} else {
			long time = System.currentTimeMillis();
			String newName = time + "" + FileManager.getExtend(item.getName());
			board.setFilename(newName);
			File file = new File(realPath + "/" + newName);
			item.write(file);
			flag = true;
		}
		
		if(flag == true){
			int result = dao.update(board);
			if(result ==0){
				out.print(getMsgBack("등록실패"));
			} else {
				out.print(getMsgURL("등록성공", "/board/list.jsp"));
			}
		}
	}
%>