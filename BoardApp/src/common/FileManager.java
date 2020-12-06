package common;

public class FileManager {
	//확장자만 추출하기
	public static String getExtend(String path) {
		//지난 여름에 놀러갔던 사진.jpg
		int lastIndex = path.lastIndexOf(".");
		String ext = path.substring(lastIndex+1, path.length());
		System.out.println(ext);
		
		return ext;
	}
//	public static void main(String[] args) {
//		String filename = "d:\\photo\\summer\\2010\\지난여름에놀러갔던사진.jpg";
//		getExtend(filename);
//	}
}
