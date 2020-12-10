<%@ page contentType="text/html; charset=UTF-8"%>
<%
	int count = 0;
	for(int i = 0; i < 1000; i++){
		count++;
	}
	out.print("서버의 실행결과 " + count);
%>