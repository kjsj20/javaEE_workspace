<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor = "yellow">
	이용에 불편을 드려 죄송합니다.
	<p>
	원인 : <%=session.getAttribute("msg") %><p>
	<a href = "/board/list">게시판 목록 가기</a>  
</body>
</html>