package com.sound.music.dao;

import java.util.List;

import com.sound.music.vo.NoticeVO;

public interface NoticeDAO {
	
		//01. 게시글 작성
		public void create(NoticeVO vo)throws Exception;
		//02. 게시글 상세보기
		public NoticeVO read(int no)throws Exception;
		//03. 게시글 수정
		public void update(NoticeVO vo)throws Exception;
		//04. 게시글 삭제
		public void delete(int no)throws Exception;
		//05. 게시글 목록보기
		public List<NoticeVO> listAll()throws Exception ;
		//06. 게시글 조회수
		public void increaseViewcnt(int no) throws Exception;

}
