<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="board.model.Board"%>
<%@page import="board.model.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	BoardDAO dao = new BoardDAO();
	List<Board> list =  dao.selectAll();
%>
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
a{
	text-decoration : none;
}
</style>
</head>
<body>

	<table>
		<tr>
			<th>No</th>
			<th>이미지</th>
			<th>제목</th>
			<th>작성자</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
		
		
		<%for(int i = 0; i < list.size(); i++){ %>
		<%Board vo = new Board();%>
		<%vo = list.get(i);%>
			<tr>
				<td><%=vo.getBoard_id() %></td>
				<td><img src ='/data/<%=vo.getFilename()%>' width = '100px'></td>
				<td><a href = 'detail.jsp?board_id=<%=vo.getBoard_id()%>'><%=vo.getTitle() %></a></td>
				<td><%=vo.getWriter() %></td>
				<td><%=vo.getRegdate() %></td>
				<td><%=vo.getHit() %></td>
			</tr>
		<%} %>
		
		<tr>
			<td colspan="6" style="text-align:center">
				[1][2][3]
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<button onClick="location.href='/board/regist_form.jsp'"> 글등록</button>
			</td>
		</tr>
	</table>

</body>
</html>
