package com.sound.music.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class FileBoardVO {

	// 전달할 필요가 있는 데이터를 변수로 선언한다.

		private String title;
		private String body;
		private String pw;
//		private	MultipartFile files;	
		private	MultipartFile[] files;		
		private int no;
		private String id;
		private int oriNo;
		private String path;
		private String oriName;
		private String saveName;
		private long len;	
		private String nick;
		private Date wday;
		private int hit;
		private int rno;
		private int filecount;
		private int start;
		
		
		
		public int getNo() {
			return no;
		}
		public void setNo(int no) {
			this.no = no;
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public int getOriNo() {
			return oriNo;
		}
		public void setOriNo(int oriNo) {
			this.oriNo = oriNo;
		}
		public String getPath() {
			return path;
		}
		public void setPath(String path) {
			this.path = path;
		}
		public String getOriName() {
			return oriName;
		}
		public void setOriName(String oriName) {
			this.oriName = oriName;
		}
		public String getSaveName() {
			return saveName;
		}
		public void setSaveName(String saveName) {
			this.saveName = saveName;
		}
		public long getLen() {
			return len;
		}
		public void setLen(long len) {
			this.len = len;
		}
		public String getNick() {
			return nick;
		}
		public void setNick(String nick) {
			this.nick = nick;
		}
		public Date getWday() {
			return wday;
		}
		public void setWday(Date wday) {
			this.wday = wday;
		}
		public int getHit() {
			return hit;
		}
		public void setHit(int hit) {
			this.hit = hit;
		}
		public int getRno() {
			return rno;
		}
		public void setRno(int rno) {
			this.rno = rno;
		}
		public int getFilecount() {
			return filecount;
		}
		public void setFilecount(int filecount) {
			this.filecount = filecount;
		}
		public int getStart() {
			return start;
		}
		public void setStart(int start) {
			this.start = start;
		}
		public int getEnd() {
			return end;
		}
		public void setEnd(int end) {
			this.end = end;
		}
		private int end;
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
