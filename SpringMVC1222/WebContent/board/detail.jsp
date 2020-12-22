<%@page import="com.model2.domain.Board"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	//정말로 포워딩이 요청을 유지했는지 테스트 해보자!!
	Board board = (Board)request.getAttribute("board");
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
.reply-box{
	background:yellow;
}
.reply-list{
	overflow:hidden;
}
.reply-list p{
	float : left;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<script>
	$(function(){
		 CKEDITOR.replace( 'content' ); //textarea 의 id 가 content인 컴포넌트를 편집기
		 $($("input[type='button']")[0]).click(function(){
			edit(); //동기방식으로 요청하겠다
		 });
		 
		 $($("input[type='button']")[1]).click(function(){
			del(); 
		 });
		 getCommentList();//댓글 목록 비동기로 가져오기!!
	});
	
	function edit(){
		$("form").attr({
			action:"/board/edit",
			method:"post"
		});
		$("form").submit();
	}
	
	function del(){
		$("form").attr({
			method:"post",
			action:"/board/delete"
		});
		$("form").submit();
	}
	
	//댓글 목록 가져오기
	function getCommentList(){
		$.ajax({
			url:"/comment/list.do",
			type:"get",
			data:{
				board_id:<%=board.getBoard_id()%>
			},
			success:function(result){
				$("#list-area").html("");
				var tag = "";
				for(var i = 0; i<result.list.length;i++){
					var json = result.list[i];
					tag += "<div class = \"reply-list\">";
			    	tag += "<p style = \"width:75%\">"+json.msg+"</p>";
			    	tag += "<p style = \"width:15%\">"+json.author+"</p>";
			    	tag += "<p style = \"width:10%\">"+json.cdate+"</p>";
			    	tag += "</div>";
				}
			    $("#list-area").html(tag); //innerHTML과 동일					
			}
		});
	}
	
	//현재 페이지가 새로고침(reloading)되지 않게, 비동기 방식으로 등록요청을 시도하자!!
	//순수 js의 ajax를 사용하면 복잡하니, jquery ajax를 사용해보자
	function registComment(){
		$.ajax({
			url:"/comment/regist.do",
			type:"post",
			data:{
				msg:$("input[name='msg']").val(),
				author:$("input[name='author']").val(),
				board_id:<%=board.getBoard_id()%>
			},
			//피드백은 success로 받는다, 즉 서버에서 에러없이 데이터가 결과값이 전송되면
			//success 우측에 명시된 익명함수가 동작하게 된다..
			success:function(result){
				alert("서보로 부터 받은 결과 데이터" + result);
				if(result==1){
					getCommentList();
				} else {
					alert("등록실패");
				}
			}
		});
	}
</script>
</head>
<body>

<h3>Contact Form</h3>

<div class="container">
  <form action="/action_page.php">
  	<input type="hidden" id="board_id" name="board_id" value="<%=board.getBoard_id()%>">
    <input type="text" id="title" name="title" value="<%=board.getTitle()%>">
    <input type="text" id="writer" name="writer" value="<%=board.getWriter()%>">
    <textarea id="content" name="content" style="height:200px"><%=board.getContent()%></textarea>
    <input type="button" value="글수정">
    <input type="button" value="글삭제">
    <input type="button" value="목록보기" onClick="location.href='/board/list.do'">
    
    <div class = "reply-box">
    	<input type = "text" name = "msg" placeholder="댓글 입력.." style = "width:75%">
    	<input type = "text" name = "author" placeholder="작성자 입력.." style = "width:10%">
    	<button type = "button" onClick="registComment()">댓글등록</button>
    </div>
    <div id = "list-area"></div>
  </form>
</div>

</body>
</html>