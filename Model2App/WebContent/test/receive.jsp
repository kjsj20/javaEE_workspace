<%@ page contentType="text/html; charset=UTF-8"%>
<%
	//메시지를 받아보자
	request.setCharacterEncoding("utf-8");
	String msg = request.getParameter("msg");
	
// 	session.setAttribute("result", msg);
	//지금 요청과 관련된 요청객체에 무언가를 담아보자!!
	//session 과 request 거의 쌍둥이인데, 단지 살수있는 생명력에만 차이있다.
	request.setAttribute("result", msg);
	//서버상의 또다른 jsp(서블릿)에 요청을 전달해보자!!
	RequestDispatcher dis = request.getRequestDispatcher("/test/result.jsp");
	dis.forward(request,response);//포워딩 시작 
// 	response.sendRedirect("/test/result.jsp");
%>