package com.sound.music.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

//다운로드 사용자 뷰
//서버의 파일을 클라이언트에게 전달하기 위한 클래스
public class DownloadUtil extends AbstractView{
	
	public DownloadUtil() {
		this.setContentType("application/download;charset=UTF-8");
	}

	@Override
	protected void renderMergedOutputModel(Map model, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		File file = (File)model.get("downloadFile");
		resp.setContentType(this.getContentType());
		resp.setContentLength((int)file.length());
		System.out.println("length"+(int)file.length());
		String Encoding = new String(file.getName().getBytes("UTF-8"),"8859_1");
		resp.setHeader("Content-Disposition", "attachment;filename="+Encoding);
		//-----------------다운로드환경설정---------------
		//-----------스트림방식으로 다운로드실행--------
		FileInputStream fin = null;
		OutputStream fout = null;
		try {
			fin = new FileInputStream(file);
			fout = resp.getOutputStream();
			FileCopyUtils.copy(fin, fout);
		}catch(Exception e) {
			System.out.println("다운로드 처리 에러="+e);
		}
		finally {
			fout.flush();
			fin.close();
			fout.close();
		}
	}
}
