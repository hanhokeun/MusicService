package com.sound.music.vo;


import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class FreeBoardVO {
	
	
	private String title;
	private String body;
	
//	private	MultipartFile files;	
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
	private int end;
	
	private int nowPage;
	
	//날짜를 wed dec 05 14:48:53 KST 2018
	//yyyy-MM-dd hh시 mm분 ss초
	public String getDate() {
		SimpleDateFormat form1 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat form2 = new SimpleDateFormat("hh시 mm분 ss초");
		
		String now = form1.format(new Date());
		String wdate = form1.format(wday);
		if(!now.equals(wdate)) {
			return wdate;
		}else {
			return form2.format(wday);			
		}
		
	}
	public String getBr() {
		String result = null;
		if(body !=null && body.length()!=0) {
			result = body.replaceAll("\r\n", "<br/>");
			
		}
		return result;
	}
	// 파일용량은 세자리마다 , 찍어서 출력
	
	public String getCo() {
		DecimalFormat form = new DecimalFormat("###,###,###,###,###,###");
		return form.format(len);
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

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}


}
