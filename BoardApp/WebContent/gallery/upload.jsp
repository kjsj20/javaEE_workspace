<%@page import="java.io.File"%>
<%@page import="common.FileManager"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>

    <%
    	request.setCharacterEncoding("utf-8");
    	//String msg = request.getParameter("msg");
    	request.getParameter("photo");
    	
    	//이미지는 글씨가 아닌 바이너리 파일이므로, request.getParameter로는 받을 수 없다!!
    	//따라서 IO, 네트워크등의 처리를 해야 하는데, 이 자체만으로도 하나의 개발 프로젝트일 것이다.
    	//해결책?? 누군가가 만든 라이브러리를 이용해서 개발시간을 단축하자!!
    	//현재 우리가 선택한 라이브러리는 cos.jar 라는 Oreilly 라는 출판사에서 제작한 컴포넌트이다!!
    	String saveDirectory = "D:/javaEE_workspace/BoardApp/WebContent/data";
    	int maxSize = 2*1024*1024;
    	String encoding = "utf-8";
    	//FileRenamePolicy policy : 업로드시, 동일한 파일을 업로드했을때?? 자동으로 이름을 부여한다..
    		//예 ) p.jpg 1p.jpg, 2p.jpg(파일명은 개발자가 주도하여 명명하므로, policy를 굳이 이용할 필요없다..)
    	try{
    		MultipartRequest multi = new MultipartRequest(request, saveDirectory, maxSize,encoding);
	    	String msg = multi.getParameter("msg");
	    	out.print("님이 전송한 메시지는 " + msg);
	    	//업로드가 완료된후 즉 서버의 저장소에 파일이 존재하게 된후 해야할일
	    	//파일명을 개발자가 정한 규칙으로 변경해야 한다.. 현재시간의 밀리세컨트까지 구해보자!!
	    	long time = System.currentTimeMillis();
	    	out.print(time);
	    	
	    	//방금 업로드한 파일명 알아맞추기(업로드 컴포넌트가 알고있다..api 조사)
	    	String ori = multi.getOriginalFileName("photo");
	    	out.print(ori);
	    	String ext = FileManager.getExtend(ori);
	    	String filename = time + "." + ext;
	    	out.print("내가 조작한 파일명은 " +  filename);
	    	
	    	//조작한 이름으로 파일명을 바꾸어야함
	    	//결국 파일을 다루어야 하므로 javaSE의 File 클래스를 이용하면 된다!!!
	    	//File 클래스의 .api문서를 찾아서, 파일명을 바꾸는 메서드를 찾아보세요, 찾으면 제보하기!!!
	    	File savedFile =  multi.getFile("photo");
	    	savedFile.renameTo(new File(saveDirectory+"/"+filename));//파일명 고체
	    	//클라이언트에게 전송할 으답정보를 가진 객체
	    	//클라이언트의 브라우저로하여금, 지정한 URL로 재접속을 시도하게 만듦
	    	//response.sendRedirect("/gallery/photo_list.jsp");
	    	out.print("업로드 완료");
    	} catch(IOException e){
    		e.printStackTrace();
    		out.print("업로드 용량이 너무 커용~");//서블릿 스레드 에러(servelet 클래스를 다뤄야함)
    	}
    %>