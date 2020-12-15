<%@page import="board.model.MybatisBoardDAO"%>
<%@page import="common.file.FileManager"%>
<%@page import="board.model.Board"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file = "/inc/lib.jsp" %>
<%
	//multipart/form-data 방식으로 전송된 파라미터는 업로드 컴포넌트를 통해서
	
	//업로드 설정은 DiskFileItemFactory 에 한다 !!!! 
	DiskFileItemFactory factory = new DiskFileItemFactory();
	//자바기반의 웹어플리케이션은 어떤 OS건 중립적 실행이 보장되어야 하므로, 특정 시스템에 의존하는 경로를 사용해서는 안됨...
	//해결책? 개발자가 경로를 넣으려고 하지말고, 프로그래밍에서 시스템 경로를 동적으로 얻어와서 이용한다
	//이때 사용할 jsp의 내장객체가 바로 application 내장객체이다!!
	//application 내장객체는, 현재 어플리케이션의 전역적 정보를 가진 객쳉이므로, 어떤 디렉토리에서 사이트가 실행되는지 조차 스스로 알아낼 수 있다..
	String realPath = application.getRealPath("/data"); //웹사이트의 루트를 기준으로 특정 파일이나, 디렉토리를 명시하면, 스스로 현재 
														//웹사이트가 얹혀진 os로부터 풀경로를 구해온다
														
	factory.setRepository(new File(realPath));
	factory.setSizeThreshold(2*1024*1024); // 2M
	factory.setDefaultCharset("utf-8");
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	List<FileItem> items = upload.parseRequest(request);//요청 객체로 부터 업로드 정보 뽑기!!
	
	Board board = new Board();
	boolean flag = false; //업로드가 완료되었는지 여부를 알수 있는 변수 선언
	MybatisBoardDAO dao = new MybatisBoardDAO();
	
	for(FileItem item: items){
		if(item.isFormField()){//text 입력기반의 컴포넌트라면...
			if(item.getFieldName().equals("title")){
				board.setTitle(item.getString());
			} else if (item.getFieldName().equals("writer")){
				board.setWriter(item.getString());
			} else if (item.getFieldName().equals("content")){
				board.setContent(item.getString());
			}
		}else{//파일이라면...
			long time = System.currentTimeMillis();
			String newName = time + "." + FileManager.getExtend(item.getName());
			board.setFilename(newName);
			File file = new File(realPath + "/" + newName);
			item.write(file); //하드디스크에 파일 생성
			flag = true;	
		}
		
		//오라클에 insert
		if(flag == true){//업로드가 성공되면 INSERT 
			int result = dao.insert(board);
			if(result ==0){
				out.print(getMsgBack("등록실패"));
			} else {
				out.print(getMsgURL("등록성공", "/board/list.jsp"));
			}
		}
	}
%>