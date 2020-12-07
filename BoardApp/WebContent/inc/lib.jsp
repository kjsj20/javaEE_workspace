<%@ page contentType = "text/html;charset=utf-8"%>
<%!
	//선언부는 멤버변수와 메서드를 정의할 수 있다
	public String getMsgBack(String msg){
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("history.back();");
		sb.append("</script>");

		return sb.toString();
	}
	public String getMsgURL(String msg,String url){
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("location.href='"+url+"'");
		sb.append("</script>");

		return sb.toString();
	} 
%>