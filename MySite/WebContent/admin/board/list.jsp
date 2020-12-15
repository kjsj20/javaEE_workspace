<%@page import="admin.member.Admin"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%
	//브라우저 프로세스를 종료하지 않았다면 여전히 기존 세션을 사용할 수 있다.
	Admin admin = (Admin)session.getAttribute("ad");
%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="/admin/inc/head.jsp" %>
</head>
<body>
<div>
<%=admin.getMid()%>님 로그인 중
<a href = "/admin/logout.jsp">로그아웃</a>
</div>
<%@ include file ="/admin/inc/topnavi.jsp" %>

<h2>게시판 목록</h2>

<table>
  <tr>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Points</th>
  </tr>
  <tr>
    <td>Jill</td>
    <td>Smith</td>
    <td>50</td>
  </tr>
  <tr>
    <td>Eve</td>
    <td>Jackson</td>
    <td>94</td>
  </tr>
  <tr>
    <td>Adam</td>
    <td>Johnson</td>
    <td>67</td>
  </tr>
</table>

</body>
</html>
