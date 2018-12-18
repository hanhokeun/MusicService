package com.sound.music.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.util.PageUtil;
import com.sound.music.vo.StaticVO;

@Service
public class StaticDAO implements StaticDAOInter {

	@Autowired
	private SqlSessionTemplate session;
	//댓글 총 개수 구하기
	@Override
	public int getRvTotalCount(int oriNo) throws Exception {
		int totalCount = session.selectOne("Static.selectTotalReply",oriNo);
		return totalCount;
	}
	//댓글 조회하기
	@Override
	public ArrayList<StaticVO> selectReply(int oriNo) throws Exception {
		return (ArrayList)session.selectList("Static.selectReply",oriNo);
	}
	//게시글 검색 후 총 개수 구하기
	@Override
	public int totalCount(StaticVO vo) {
		int totalCount = session.selectOne("Static.searchCount", vo);
		return totalCount;
	}
	//게시글 입력하기
	@Override
	public void insert(StaticVO vo, String kind) {
		if(kind.equals("static")) {
			//게시판 글쓰기 처리
			session.insert("Static.insertStatic",vo);
		}else if(kind.equals("file")){
			session.insert("Static.insertFile",vo);
		}
	}
	//게시글 조회수 증가
	@Override
	public void increaseHit(int no) throws Exception {
		session.update("Static.updateHit",no);
	}
	//게시글의 파일정보 보기
	@Override
	public ArrayList selectFileInfo(int oriNo) throws Exception {
		return (ArrayList)session.selectList("Static.fileInfo",oriNo);
	}
	//게시글 댓글 등록
	@Override
	public void insertReply(StaticVO vo) throws Exception {
		session.insert("Static.insertReply",vo);
	}
	//게시글 댓글 수정하기
	@Override
	public void updateReply(StaticVO vo) throws Exception {
		session.update("Static.updateReply", vo);
	}
	//게시글 댓글 삭제하기
	@Override
	public void deleteReply(StaticVO vo) throws Exception {
		session.update("Static.deleteReply", vo);
	}
	
	//글쓰기 상세 글보기
	@Override
	public StaticVO detail(int no) throws Exception {
		return (StaticVO)session.selectOne("Static.selectDetail",no);
	}

	//통계 글 수정하기
	@Override
	public void update(StaticVO vo, String kind) throws Exception {
		if(kind.equals("static")) {
			//게시판 글수정 처리
			session.update("Static.updateStatic", vo);
			System.out.println("게시판 수정 완료");
		}else if(kind.equals("file")){
			//수정된 파일 DB에 저장
			session.insert("Static.insertFile",vo);
		}
	}
	//통계 글 삭제하기
	@Override
	public void delete(int oriNo) throws Exception {
		session.delete("Static.deleteStatic", oriNo);
	}
	//통계글 삭제하면서 파일도 삭제하기
	@Override
	public void deleteAllFile(int oriNo) throws Exception {
		session.delete("Static.deleteAllFile",oriNo);
	}
	//다운로드 횟수 구하기
	@Override
	public void downloadCount(int fileNo) throws Exception {
		session.update("Static.downloadCount", fileNo);
	}
	//원글의 첨부 파일 삭제하기
	@Override
	public void deleteFile(int fileNo) throws Exception {
		session.delete("Static.deleteFile",fileNo);
	}
	//삭제 or 다운로드 할 파일 정보구하기
	@Override
	public StaticVO downNDelFile(int fileNo) throws Exception {
		return session.selectOne("Static.DfileInfo", fileNo);
	}
	//통계 게시글 검색하기
	@Override
	public ArrayList<StaticVO> SearchList(StaticVO vo) throws Exception {
		ArrayList list = (ArrayList)session.selectList("Static.searchList", vo);
		return list;
	}
}
