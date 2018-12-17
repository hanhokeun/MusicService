package com.sound.music.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.sound.music.util.PageUtil;
import com.sound.music.vo.FreeBoardVO;


public interface FreeBoardService {

	
	
	//게시물 정보를 db에 기록할 함수
	public void insertBoard(FreeBoardVO vo, HttpSession session, ArrayList list) throws Exception;
	//페이지 이동정보를 만들어 주는 함수
	public PageUtil getPageInfo(int nowPage)throws Exception;
	//게시물 정보 구하기 함수
	public ArrayList getBoardList(PageUtil pInfo)throws Exception;
	//상세보기 처리함수
	public FreeBoardVO getBoardView(int oriNo)throws Exception;
	//상세보기 첨부파일 처리함수
	public ArrayList getFileInfo(int oriNo)throws Exception;
	//조회수 증가 처리함수
	public void updateHit(int oriNo,HttpSession session)throws Exception;
	//다운로드 파일정보 검색질의 실행함수
	public FreeBoardVO getDownloadFile(int fileNo)throws Exception;
	//글수정 질의명령 실행 함수
	public void updateBoard(FreeBoardVO vo, ArrayList list)throws Exception;
	//글 삭제 명령 실행함수
	public int deleteBoard(int oriNo);
	
	



}
