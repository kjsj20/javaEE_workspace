<%@page import="board.model.ImageBoard"%>
<%@page import="board.model.ImageBoardDAO"%>
<%@page import="common.FileManager"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page contentType = "text/html;charset=utf-8"%>
<%@ include file = "/inc/lib.jsp" %>
<%!
	String saveDir="D:/javaEE_workspace/BoardApp/WebContent/data";
	int maxSize = 3 * 1024 * 1024;
	//실습했던 예제보다 기능이 더 추가됨, db에 넣어야함 .. DAO이용 
	ImageBoardDAO dao = new ImageBoardDAO();
%>
<%	

	//실습햇던 예제보다 기능이 더 추가됨, db에 넣어야 함.. DAO이용
	request.setCharacterEncoding("utf-8");
	
	DiskFileItemFactory itemFactory = new DiskFileItemFactory();
	itemFactory.setRepository(new File(saveDir));
	itemFactory.setSizeThreshold(maxSize);
	
	ServletFileUpload upload = new ServletFileUpload(itemFactory);
	
	List<FileItem> items = upload.parseRequest(request); //업로드된 정보 분석!!! 각각의 컴포넌트들을 FileItem 단위로 쪼갠다
	
	ImageBoard board = new ImageBoard(); 
	for(FileItem item : items){
		if(item.isFormField()){
			if(item.getFieldName().equals("author")){
				board.setAuthor(item.getString());
			} else if (item.getFieldName().equals("title")){
				board.setTitle(item.getString());
			} else if (item.getFieldName().equals("content")){
				board.setContent(item.getString());
			} 
		} else { 
			String newName = System.currentTimeMillis() + "." + FileManager.getExtend(item.getName());
			String destFile = saveDir + "/" + newName;
			File file = new File(destFile);
			item.write(file);//물리적 저장 시점
			out.print("업로드 완료");
			board.setFilename(newName);
		}
	}
	
	int result = dao.insert(board);
	
	if(result == 0){
		out.print(getMsgBack("등록실패"));
	} else {
		out.print(getMsgURL("등록성공", "/imageboard/list.jsp"));
	}
%>