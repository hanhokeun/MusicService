package com.sound.music.dao;

import java.util.ArrayList;
import java.util.List;

import com.sound.music.util.PageUtil;
import com.sound.music.vo.StaticVO;


public interface StaticDAOInter {
	
	//페이지 정보구하기 - 총페이지구하기
	public int totalCount() throws Exception;
	//통계 게시글 목록보기
	public ArrayList<StaticVO> List(StaticVO vo) throws Exception;
	//통계 게시글 입력하기
	public void insert(StaticVO vo, String kind) throws Exception;
	//통계 게시글 보기
	public StaticVO detail(int no) throws Exception;
	//통계 게시글 수정
	public void update(StaticVO vo,String kind)throws Exception;
	//통계 게시글 삭제
	public void delete(int no)throws Exception;
	//통계 게시글 삭제하면서 파일도 삭제
	public void deleteAllFile(int no) throws Exception;
	//통계 게시글 조회수 증가
	public void increaseHit(int no) throws Exception;
	//통계 게시글 파일정보 검색
	public ArrayList<StaticVO> selectFileInfo(int no) throws Exception;
	//게시글 파일 삭제
	public void deleteFile(int no) throws Exception;
	//댓글 조회
	public ArrayList<StaticVO> selectReply(int no) throws Exception;
	//댓글 등록
	public void insertReply(StaticVO vo) throws Exception;
	//댓글 수정
	public void updateReply(StaticVO vo) throws Exception;
	//댓글 삭제
	public void deleteReply(StaticVO vo) throws Exception;
	//다운로드 정보 검색, 삭제할 파일 정보검색
	public StaticVO downNDelFile(int no) throws Exception;
	//다운로드 횟수 증가
	public void downloadCount(int no) throws Exception;
}

