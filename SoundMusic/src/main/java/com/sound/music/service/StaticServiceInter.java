package com.sound.music.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.sound.music.util.PageUtil;
import com.sound.music.vo.StaticVO;

public interface StaticServiceInter {

	//페이지 정보 처리하기
	public PageUtil getPageInfo(int nowPage) throws Exception;
	//통계 게시글 목록보기
	public ArrayList<StaticVO> List(PageUtil pInfo) throws Exception;
	//통계 게시글 등록
	public void insertStatic(StaticVO vo, HttpSession session,ArrayList list)throws Exception;
	//통계 게시글 보기
	public StaticVO detail(int no) throws Exception;
	//통계 게시글 수정
	public void update(StaticVO vo)throws Exception;
	//통계 게시글 삭제
	public void delete(int no)throws Exception;
	//통계 게시글 조회수 증가
	public void increaseHit(int no,HttpSession session) throws Exception;
	//통계 게시글 파일정보 검색
	public ArrayList<StaticVO> selectFileInfo(int no) throws Exception;
	//댓글 등록
	public void insertReply(StaticVO vo) throws Exception;
	//댓글 수정
	public void updateReply(StaticVO vo) throws Exception;
	//댓글 삭제
	public void deleteReply(int no) throws Exception;

}
