<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
table{
	width:70%;
}
td{
	border: 2px solid #cccccc;
}
td input, textarea{
	width : 97%;
	font-size:1.2em;
}

textarea{
	height: 150px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
	$($("button")[0]).click(function(){
		location.href = "regist.jsp";
		$("form").submit();
	});
	
	$($("button")[1]).click(function(){
		location.href = "list.jsp";
	});
	
	$("form").attr({
		method : "post",
		action:"regist.jsp"
	});
});
</script>
<body>
	<form>
		<table align = "center">
			<tr>
				<td><input type = "text" name = "writer" placeholder = "작성자 입력"></td>
			</tr>
			<tr>
				<td><input type = "text" name = "title" placeholder = "제목입력"></td>
			</tr>
			<tr>
				<td><textarea name = "content" placeholder = "내용 입력"></textarea></td>
			</tr>
			<tr>
				<td align = "center">
					<button type = "button">등록</button>
					<button type = "button">목록</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>