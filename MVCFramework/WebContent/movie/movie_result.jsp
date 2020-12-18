<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
당신이 선택한 영화에 대한판단결과 <p><p>
<%=session.getAttribute("msg") %> <br>
<a href = "/movie/movie_form.jsp">선택폼으로 가기</a>
</body>
</html>