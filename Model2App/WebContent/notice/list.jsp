<%@page import="com.model2.notice.domain.Notice"%>
<%@page import="common.board.Pager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	//jsp 에서는 이미 내장객체로 지원되기 때문에 session 으로 사용하면됨
	List list = (List)request.getAttribute("noticeList");
	Pager pager = new Pager();
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
			<th>제목</th>
			<th>작성자</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
		
		<%int num = pager.getNum(); %>
		<%int curPos = pager.getCurPos();%>
		<%for(int i = 0; i < pager.getPageSize(); i++){ %>
		<%if(num<1)break; %>
		<%Notice notice = (Notice)list.get(curPos++);%>
			<tr>
				<td><%=num--%></td>
 				<td><a href = '/notice/detail.do?notice_id=<%=notice.getNotice_id()%>'><%=notice.getTitle() %></a></td> 
				<td><%=notice.getWriter() %></td>
				<td><%=notice.getRegdate() %></td>
				<td><%=notice.getHit() %></td>
			</tr>
		<%} %>
		
		<tr>
			<td colspan="5" style="text-align:center">
				<%for(int i = pager.getFirstPage(); i <= pager.getLastPage(); i++){%>
					<%if(i <= pager.getTotalPage()) {%>
						<a href = "/board/list.jsp?currentPage=<%=i%>">[<%=i %>]</a>
					<%} %>
				<%} %>
			</td>
		</tr>
		<tr>
			<td colspan="5">
				<button onClick="location.href='/notice/regist_form.jsp'"> 글등록</button>
			</td>
		</tr>
	</table>

</body>
</html>
