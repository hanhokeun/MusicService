package com.sound.music.dao;

import java.util.ArrayList;

import com.sound.music.vo.FreeBoardVO;
import com.sound.music.vo.StaticVO;

public interface FreeBoardDAO {
	
	//등록 질의 실행 호출
		public void insertBoard(FreeBoardVO vo,String kind)throws Exception;
				
	//게시물 총 개수 구하기 질의 실행 함수
		public int getTotalCount() throws Exception;
				
	//해당 페이지에 보여줄 게시물 정보 구하기 질의 실행 함수
		public ArrayList getBoardList(FreeBoardVO vo)throws Exception;
	//상세보기 질의 명령 실행 함수
		public FreeBoardVO getBoardView(int no) throws Exception;
	//첨부파일 검색질의 실행함수 (상세보기 화면에 뿌려질 내용)
		public ArrayList getFileInfo(int oriNo) throws Exception;
	//조회수 증가질의 실행 함수 (상세보기 화면에 뿌려지기 위함)
		public void updateHit(int no) throws Exception;
		
		public FreeBoardVO getDownload(int fileNo) throws Exception;
	//글수정 질의명령 실행 함수
		public void updateBoard(FreeBoardVO vo,String kind) throws Exception;
		// 글 삭제 명령 
		public int deleteBoard(int oriNo);
		//댓글 총 개수 구하기
		public int getRvTotalCount(int no) throws Exception;
		//댓글 조회
		public ArrayList selectReply(FreeBoardVO vo) throws Exception;
		//댓글 등록
		public void insertReply(FreeBoardVO vo) throws Exception;
		//댓글 수정
		public void updateReply(FreeBoardVO vo) throws Exception;
		//댓글 삭제
		public void deleteReply(FreeBoardVO vo) throws Exception;

		public ArrayList mnetchart(FreeBoardVO vo)throws Exception;

		public ArrayList bugschart(FreeBoardVO vo)throws Exception;
}
