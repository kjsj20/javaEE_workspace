package common;

public class FileManager {
	//Ȯ���ڸ� �����ϱ�
	public static String getExtend(String path) {
		//���� ������ ����� ����.jpg
		int lastIndex = path.lastIndexOf(".");
		String ext = path.substring(lastIndex+1, path.length());
		System.out.println(ext);
		
		return ext;
	}
//	public static void main(String[] args) {
//		String filename = "d:\\photo\\summer\\2010\\�������������������.jpg";
//		getExtend(filename);
//	}
}
