package com.sound.music.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.springframework.web.multipart.MultipartFile;

public class StaticVO {

	//글의 상세 보기
	private int no;
	private int oriNo;
	private String title;
	private String body;
	private MultipartFile[] files;
	private int hit;
	private Date wday;
	//게시글 목록보기
	private int start;
	private int end;
	private int rno;
	private int fileCount;
	//파일의 정보
	private String path;
	private String oriName;
	private String saveName;
	private long len;
	//댓글 정보
	private String pw;
	private int like;
	private String mId;
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getDate() {
		SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
		return form.format(wday);
	}
	public String getBrBody() {
		String temp=body;
		if(temp!=null && temp.length()!=0) {
			temp=temp.replaceAll("\n", "<br/>");
		}
		return temp;
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
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getFileCount() {
		return fileCount;
	}
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}
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
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Date getWday() {
		return wday;
	}
	public void setWday(Date wday) {
		this.wday = wday;
	}
	public int getLike() {
		return like;
	}
	public void setLike(int like) {
		this.like = like;
	}
}
