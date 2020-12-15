package common.file;

import java.io.File;

public class FileManager {
	public static String getExtend(String path) {
		int lastIndex = path.lastIndexOf(".");
		String ext = path.substring(lastIndex+1, path.length());
		System.out.println(ext);
		
		return ext;
	}
	
	//파일 삭제 : 호출자는 삭제하고싶은 파일의 경로를 넘긴다..
	public static boolean deleteFile(String path) {
		File file = new File(path);
		return file.delete(); 
	}
//	public static void main(String[] args) {
//		String filename = "d:\\photo\\summer\\2010\\�������������������.jpg";
//		getExtend(filename);
//	}
}
