<%@page import="java.util.List"%>
<%@page import="board.model.QnADAO"%>
<%@page import="board.model.QnA"%>
<%@page import="board.model.Notice"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.model.NoticeDAO"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="db.DBManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%
	QnADAO dao = new QnADAO();
	List<QnA> list = dao.selectAll();
	int totalRecord = list.size(); //총 레코드 수 
	int pageSize = 10; //한 페이지당 보여질 레코드 수 
	int totalPage = (int)Math.ceil((double)totalRecord/pageSize); //총 페이지
	int blockSize = 10;
	int currentPage = 1; //현재 페이지 
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int firstPage = currentPage - (currentPage - 1) % blockSize; //반복문의 시작 값
	int lastPage = firstPage + (blockSize-1); // 반복문의 끝값
	int num = totalRecord - ((currentPage-1) * pageSize); // 페이지당 시작 번호 (힌트 : 여전히 위에 있는 모든 변수를 조합하면 금방나옴.)
	int curPos = (currentPage - 1) * pageSize; //페이지당 List에서의 시작 index
%>
<%= "pageSize : " + pageSize + "<br>" %>
<%="총레코드 수는 : " + totalRecord + "<br>" %>
<%="totalPage : " + totalPage + "<br>" %>
<%="blockSize : " + blockSize + "<br>" %>
<%="currentPage : " + currentPage + "<br>" %>
<%="num : " + num + "<br>" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table {
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	border: 1px solid #ddd;
}

th, td {
	text-align: left;
	padding: 16px;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

img {
	box-sizing: border-box;
}

a {
	text-decoration: none;
}

.pageNum {
	font-size:20pt;
	color:red;
	font-weight:bold;
}
</style>
<script>
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function() {
		$("button").on("click", function() {
			//자바스크립트에서 링크 구현? 
			location.href = "/qna/regist_form.jsp";
		});
	}); //onload
</script>
</head>
<body>

	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
			<th>작성자</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
	<%for(int i =0; i<pageSize; i++){ %>
		<%if(num <1)break; %>
		<% 
			QnA qna = list.get(curPos++);
		%>
		<tr>
			<td><%=num--%></td>
			<td>
				<%if(qna.getDepth()>0){ %>
				<img src="images/reply.png" style ="margin-left:<%=10*qna.getDepth()%>">
				<%} %>
			</td>
			<td><%=qna.getTitle() %></td>
			<td><%=qna.getWriter() %></td>
			<td><%=qna.getRegdate() %></td>
			<td><%=qna.getHit() %></td>
		</tr>
	<%} %>
		<tr>
			<td colspan="5" style = "text-align:center">
			<%if (firstPage -1 > 0){ %>
				<a href = "/qna/list2.jsp?currentPage=<%= firstPage - 1%>">◀</a>
			<%} else {%>
				<a href ="javascript:alert('처음 페이지 입니다');">◀</a>
				<% } %>
			<%for(int i = firstPage; i<=lastPage; i ++){ %>
			<%if(i > totalPage)break; %>
			<a <%if(currentPage == i){ %>class = "pageNum"<%} %> href = "/qna/list2.jsp?currentPage=<%=i%>">[<%=i %>]</a>
			<%} %>
			<%if((lastPage+1) < totalPage){ %>
			<a href = "/qna/list2.jsp?currentPage=<%= lastPage + 1%>">▶</a>
			<%} else {%>
				<a href ="javascript:alert('마지막 페이지 입니다');">▶</a>
				<% } %>
			</td>
		</tr>
		<tr>
			<td colspan="5">
				<button>글등록</button>
			</td>
		</tr>
		<tr>
			<td colspan="5" style="text-align: center"><%@ include
					file="/inc/footer.jsp"%></td>
		</tr>

	</table>

</body>
</html>