package com.sound.music.util;

import java.io.File;

//파일 업로드를 할 때 발생할 문제점을 해결하기 위한 기능
public class FileUtil {

	//업로드 폴더 존재하지 않을 시 자동 생성
	public static void makeFolder(String path) {
		//경로 받아 File클래스 생성
		File file = new File(path);
		file.mkdirs(); //강제 폴더 생성
	}
	
	//같은 이름 파일 존재할 시 중복되지 않도록 예방
	public static String renameTo(String path,String name) {
		//저장할 폴더 생성
		makeFolder(path);
		String TempName=name; //현재 이름 기억
		File file= new File(path,TempName);
		if(file.exists()) {
			int index=name.lastIndexOf(".");
			String fileName=name.substring(0, index);
			String extName=name.substring(index+1);
			//중복 방지를 위해 초,분을 파일명에 붙이기
			TempName=fileName+System.currentTimeMillis()+"."+extName;
			file=new File(path,TempName);
		}
		return TempName;
	}
	
}
