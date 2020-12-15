<%@page import="board.model.MybatisBoardDAO"%>
<%@page import="common.board.Pager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="board.model.Board"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	MybatisBoardDAO dao = new MybatisBoardDAO();
	Pager pager = new Pager();
	List<Board> list =  dao.selectAll();
	pager.init(request, list);
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
		
		<%int num = pager.getNum(); %>
		<%int curPos = pager.getCurPos();%>
		<%for(int i = 0; i < pager.getPageSize(); i++){ %>
		<%if(num<1)break; %>
		<%Board board = list.get(curPos++);%>
			<tr>
				<td><%=num--%></td>
				<td><img src ='/data/<%=board.getFilename()%>' width = '100px'></td>
				<td><a href = '/board/detail.jsp?board_id=<%=board.getBoard_id()%>'><%=board.getTitle() %></a></td>
				<td><%=board.getWriter() %></td>
				<td><%=board.getRegdate() %></td>
				<td><%=board.getHit() %></td>
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
