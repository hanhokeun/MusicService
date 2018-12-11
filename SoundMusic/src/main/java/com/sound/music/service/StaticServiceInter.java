package com.sound.music.service;

import com.sound.music.vo.StaticVO;

public interface StaticServiceInter {

	//통계 게시글,댓글 보기
	public StaticVO detail(int no) throws Exception;
	//통계 게시글, 댓글 수정
	public void update(StaticVO vo)throws Exception;
	//통계 통계 게시글, 댓글 삭제
	public void delete(int no)throws Exception;
	
}
