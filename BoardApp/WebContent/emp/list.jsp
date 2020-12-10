<%@page import="emp.model.Dept"%>
<%@page import="java.util.List"%>
<%@page import="emp.model.DeptDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	DeptDAO dao = new DeptDAO();
	List<Dept> list = dao.selectAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%for(int i = 0; i < list.size(); i++){ %>
<%Dept dept = list.get(i); %>
부서번호<%=dept.getDeptno()%>, 부서명<%=dept.getDname() %>, 위치<%=dept.getLoc() %><br>
<%} %>
</body>
</html>