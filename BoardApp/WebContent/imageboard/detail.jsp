<%@page import="board.model.Notice"%>
<%@page import="board.model.NoticeDAO"%>
<%@ page contentType = "text/html;charset=utf-8"%>
<%@ page import = "db.DBManager"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet"%>
<%   
   DBManager dbManager = new DBManager();
   Connection con = dbManager.getConnection();
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   //select
 
   String notice_id = request.getParameter("notice_id");
   NoticeDAO noticeDAO = new NoticeDAO();
   Notice notice = noticeDAO.select(Integer.parseInt(notice_id)); 
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

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
} 
textarea{
   background-color : yellow;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
   $($("input[type='button']")[0]).click(function(){
      location.href = "/board/list.jsp";
   });

   $($("input[type='button']")[1]).click(function(){
	   if(confirm("수정하시겠어요?")){
			//입력양식을 서버에 전송!
		  $("form").attr({
			 method : "post",
			 action : "/board/edit.jsp"
			 //form 속성을 이렇게 바꿔주고
		  });
		  $("form").submit(); //전송행위
	   }
   });

   $($("input[type='button']")[2]).click(function(){
      //입력양식을 서버에 전송!
	  if(confirm("수정하시겠어요?")){
		  $("form").attr({
			 method : "post",
			 action : "/board/delete.jsp"
			 //form 속성을 이렇게 바꿔주고
		  });
		  $("form").submit(); //전송행위
	  }
   });
});
</script>

</head>
<body>
<div class="container">
  <form>
    <label for="fname">First Name</label>
	<input type="hidden" name="notice_id" value="<%=notice.getNotice_id()%>">
    <input type="text" id="fname" name="author" placeholder="Your name.." value="<%=notice.getAuthor()%>">

    <label for="lname">Title</label>
    <input type="text" id="lname" name="title" placeholder="Your title.." value="<%=notice.getTitle()%>">

    <label for="subject">Content</label>
    <textarea id="subject" name="content" placeholder="Write something.." style="height:200px"><%=notice.getContent()%></textarea>

    <input type="button" value="목록으로">
   <input type="button" value="수정하기">
   <input type="button" value="삭제하기">
  </form>
</div>
<div style="text-align:center">
<%@ include file="/inc/footer.jsp"%>
</div>
</body>
</html>