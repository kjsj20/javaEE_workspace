<%@page import="board.model.NewsDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file = "/inc/lib.jsp" %>
<%
	/*넘겨받은 파라미터 값을 이용하여 누스기사 등록하기*/
	//jsp 문서에서만 사용가능한 서버측의 태그를 사용해보자!!!
	//사실상 자바의 코드이지만, 코드량을 단축시키기 위해 태그형식으로 지원한다..
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="news" class = "board.model.News"/>
<jsp:setProperty property = "*" name = "news"/>
<%
	NewsDAO dao = new NewsDAO();
	int result =dao.insert(news);
	
	if(result == 0){
		out.print(getMsgBack("등록실패"));
	} else {
		out.print(getMsgURL("등록 성공", "list.jsp"));
	}
%>
