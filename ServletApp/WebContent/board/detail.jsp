<%@page import="board.model.MybatisBoardDAO"%>
<%@page import="board.model.Board"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String board_id = request.getParameter("board_id");
	MybatisBoardDAO dao = new MybatisBoardDAO();
	Board board = dao.select(Integer.parseInt(board_id));
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=button] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=button]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
	var bt_list = $("input[type='button']")[0];
	var bt_edit = $("input[type='button']")[1];
	var bt_del = $("input[type='button']")[2];
	
	$(bt_list).click(function(){
		
	});
	
	$(bt_edit).click(function(){
		edit();
	});
	$(bt_del).click(function(){
		del();
	});
});

function edit(){
	$("form").attr({
		enctype:"multipart/form-data",
		method:"post",
		action:"edit.jsp"
	});
	$("form").submit();
}

function del(){
	$("form").attr({
		method:"post",
		action:"del.jsp"
	});
	$("form").submit();
}

</script>
</head>
<body>

<h3>게시판 상세보기</h3>

<div class="container">
  <form>
  	<input type="hidden" name="board_id" value="<%=board.getBoard_id() %>">
  	<input type = "hidden" name ="filename" value = "<%=board.getFilename() %>">
    <input type="text" name="writer" value="<%=board.getWriter()%>" >
	
    <input type="text" name="title" value="<%=board.getTitle() %>">
    
    <textarea name="content" style="height:200px"><%=board.getContent() %></textarea>
    
	<input type = "file" name = "photo"><p>
	
    <input type="button" value="목록보기" onClick="location.href='/board/list.jsp'">
    <input type="button" value="수정하기">
    <input type="button" value="삭제하기">
    
    
  </form>
</div>

</body>
</html>
