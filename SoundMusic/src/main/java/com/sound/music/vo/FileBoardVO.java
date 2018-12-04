package com.sound.music.vo;

import org.springframework.web.multipart.MultipartFile;

public class FileBoardVO {

	// 전달할 필요가 있는 데이터를 변수로 선언한다.
	private String title;
	private String body;
	private String pw;
	private MultipartFile[] files;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public MultipartFile[] getFiles() {
		return files;
	}
	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}
	
	
}
