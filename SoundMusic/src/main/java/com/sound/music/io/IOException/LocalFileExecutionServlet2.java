package com.sound.music.io.IOException;

import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LocalFileExecutionServlet2{

	public void service(String fileName)
		throws ServletException, IOException{
		
		//System.out.println("fileName : " + fileName);
		
		if(fileName ==null || fileName=="") {
			
			String directory = "E:/data/python4/dist/concert_dataupdate.exe"; 
			
			Runtime rt = Runtime.getRuntime();
			System.out.println("directory: " + directory);
			Process p;
			
				p = rt.exec(directory);
				try {
					System.out.println("연결");
					p.waitFor();
				} catch (Exception e) {
					System.out.println("연결 에러: "+e);
					e.printStackTrace();
				}
		}
		System.out.println("concertListUpdate요청 컨트롤러 종료");
	}
}
