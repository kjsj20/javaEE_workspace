<%@page import="common.file.FileManager"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.DefaultFileItemFactory"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	/*
���� ���ε� ������Ʈ�� ������ ���������� ������, �� �� ����ġ�� ���� ���ε� ������Ʈ�� ����غ���
*/ request.setCharacterEncoding("utf-8");
String saveDir = "D:/javaEE_workspace/BoardApp/WebContent/data";
int maxSize = 2 * 1024 * 1024;
//���ε� ��ü�� �������ִ� ���丮 ��ü : �ַ� ������ ���(������ ������, ������ �뷮����..)
DefaultFileItemFactory itemFactory = new DefaultFileItemFactory();
itemFactory.setRepository(new File(saveDir)); //����� ��ġ!! ����� ��ġ �������� ������ �ƴ� �ӽ� ���丮
itemFactory.setSizeThreshold(maxSize); //�뷮�� ������ ũ��� ����

//�� ��ü�� ���� ���ε带 �����Ѵ�.
ServletFileUpload upload = new ServletFileUpload(itemFactory); //���� ������ �������� �μ������� !!

//FileItem �� Ŭ���̾�Ʈ�� ���� ���� �ϳ� �ϳ��� �ǹ��Ѵ�. �� html ������ input �ؽ�Ʈ�ڽ�, file ������Ʈ ��
//�츮�� ��� input type = "text", input type = "file" 2����  FileItem �����ӿ�ũ�� ����
List<FileItem> items = upload.parseRequest(request);//���ε� ������Ʈ���� Ŭ���̾�Ʈ�� ��û ������ �����Ѵ�!!!

for (FileItem item : items) {
	//out.print("����"+item.getFieldName());	
	//�ݺ������� ó���Ǵٺ���, ���ϸ� ���� ó���� �Ϸ���, ���� ������ �ʿ���..
	if (!item.isFormField()) {
		//���ε� ó������. �޸𸮻��� �̹��� ������ ���� ������ ���Ϸ� ��������!!
		
		String ext = FileManager.getExtend(item.getName());
		String filename = System.currentTimeMillis() + "." + ext;
		File file = new File(saveDir+"/"+filename);
		item.write(file);//���� ������ ���� Ŭ������ �ν��Ͻ��� ����!!
		out.print("���� �ۼ�<br>");
		out.print("���� ���ϸ�:" + item.getName() +"<br>");
		out.print("������ ���ϸ�:" + filename +"<br>");
		out.print("����� ��ġ:" + saveDir +"<br>");
		out.print("���ε����� ũ�� :" + item.getSize() +"bytes<br>");
		
	}
}
%>