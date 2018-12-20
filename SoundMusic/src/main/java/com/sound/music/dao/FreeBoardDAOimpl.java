package com.sound.music.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.vo.FreeBoardVO;
import com.sound.music.vo.StaticVO;

@Service
public class FreeBoardDAOimpl implements FreeBoardDAO {
	
	
	@Autowired
	private SqlSessionTemplate session;
	
	
	
	//글 등록함수
	@Override
	public void insertBoard(FreeBoardVO vo, String kind) throws Exception{
		if(kind.equals("board")) {
			session.insert("freeBoard.insertBoard",vo);
		}else if(kind.equals("fileInfo")) {
			session.insert("freeBoard.insertFileInfo",vo);
		}

	}
	// 최대글 개수 구하기 (페이징 처리용)
	@Override
	public int getTotalCount()throws Exception {
		int result = session.selectOne("freeBoard.totalCount");
		return result;
	}
	//글 목록보기
	@Override
	public ArrayList getBoardList(FreeBoardVO vo)throws Exception {
		System.out.println("목록 가져오기 시작");
		return (ArrayList)session.selectList("freeBoard.boardList",vo);
		
	}
	//글 상세보기
	@Override
	public FreeBoardVO getBoardView(int no)throws Exception {
		
		return (FreeBoardVO)session.selectOne("freeBoard.boardView",no);
	}
	// 파일상세보기
	@Override
	public ArrayList getFileInfo(int oriNo)throws Exception {
		
		return (ArrayList)session.selectList("freeBoard.fileInfo",oriNo);
	}
	// 조회수 증가
	@Override
	public void updateHit(int no) throws Exception{
		session.update("freeBoard.updateHit",no);	
	}
	// 파일 다운로드
	@Override
	public FreeBoardVO getDownload(int fileNo)throws Exception {
		
		return (FreeBoardVO)session.selectOne("freeBoard.download",fileNo);
	}
	// 글 수정 함수
	@Override
	public void updateBoard(FreeBoardVO vo,String kind)throws Exception {
		
		if(kind.equals("free")) {
			//게시판 글수정 처리
			session.update("freeBoard.updateBoard", vo);
		}else if(kind.equals("file")){
			//수정된 파일 DB에 저장
			session.insert("freeBoard.insertFileInfo",vo);
		}
		

	}
	@Override
	public int deleteBoard(int oriNo) {
		System.out.println("DAO 시작");
		int cnt = session.update("freeBoard.deleteBoard",oriNo);
		System.out.println("DAO 종료");
		return cnt;
	}
	//댓글 총 개수 구하기
	@Override
	public int getRvTotalCount(int oriNo) throws Exception {
		int totalCount = session.selectOne("freeBoard.selectTotalReply",oriNo);
		return totalCount;
	}
	//댓글 조회하기
	@Override
	public ArrayList selectReply(FreeBoardVO vo) throws Exception {
		ArrayList list=(ArrayList)session.selectList("freeBoard.selectReply",vo);
		return list;
	}
	//게시글 댓글 등록
	@Override
	public void insertReply(FreeBoardVO vo) throws Exception {
		session.insert("freeBoard.insertReply",vo);
	}
	//게시글 댓글 수정하기
	@Override
	public void updateReply(FreeBoardVO vo) throws Exception {
		session.update("freeBoard.updateReply", vo);
	}
	//게시글 댓글 삭제하기
	@Override
	public void deleteReply(FreeBoardVO vo) throws Exception {
		session.update("freeBoard.deleteReply", vo);
	}
	//mnet 차트 가져오기
	@Override
	public ArrayList mnetchart(FreeBoardVO vo) throws Exception {
		ArrayList list=(ArrayList)session.selectList("freeBoard.mnetCraw",vo);
		return list;
	}
	//bugs chart가져오기
	@Override
	public ArrayList bugschart(FreeBoardVO vo) throws Exception {
		ArrayList list=(ArrayList)session.selectList("freeBoard.bugsCraw",vo);
		return list;
	}
}
