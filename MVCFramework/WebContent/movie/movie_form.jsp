<%@page import="blood.model.BloodAdvisor"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
// 	String blood = "";//초기값
// 	if(request.getParameter("blood")!=null){
// 		blood = request.getParameter("blood");
// 	}
// 	out.print("전송된 혈액형은 : "+ blood);
// 	out.print("<p>");
// 	//혈액형에 대한 판단 메시지 작성 및 출력
	
// 	out.print(msg);
// 	out.print("<p>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function send(){
	var form = document.querySelector("form");
	form.action = "/movie.do";
	form.method="post";
	form.submit();
}
</script>
</head>
<body>
	
	<form>
		<input type = "hidden" name = "class" value = "movie.controller.MovieController">
		<select name = "movie">
			<option>영화를 선택하세요</option>
			<option value = "미션임파서블5">미션임파서블5</option>
			<option value = "스타워즈">스타워즈</option>
			<option value = "존윅3">존윅3</option>
			<option value = "분노의질주">분노의질주</option>
		</select>
	
		<button type = "button" onClick = "send()">분석보기</button>
	</form>
</body>
</html>