package com.sound.music.dao;

import java.util.ArrayList;

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
	//게시글 총 개수 구하기
	@Override
	public int totalCount() throws Exception{
		int totalCount=session.selectOne("static.totalCount");
		return totalCount;
	}
	//게시글 입력하기
	@Override
	public void insert(StaticVO vo, String kind) {
		if(kind.equals("static")) {
			//게시판 글쓰기 처리
			session.insert("static.insertStatic",vo);
		}else if(kind.equals("file")){
			session.insert("static.insertFile",vo);
		}
	}
	//통계 게시글 목록보기
	@Override
	public ArrayList<StaticVO> List(StaticVO vo) throws Exception {
		return (ArrayList)session.selectList("static.selectList",vo);
	}
	//게시글 조회수 증가
	@Override
	public void increaseHit(int no) throws Exception {
		
	}
	//게시글 답글 달기
	@Override
	public StaticVO insertReply(int oriNo) throws Exception {
		return null;
	}

	@Override
	public void updateReply(StaticVO vo) throws Exception {
		
	}

	@Override
	public void deleteReply(int no) throws Exception {
	
	}
	
	//글쓰기 상세 글보기
	@Override
	public StaticVO detail(int no) throws Exception {
		return null;
	}

	//통계 글 수정하기
	@Override
	public void update(StaticVO vo) throws Exception {

	}

	//통계 글 삭제하기
	@Override
	public void delete(int no) throws Exception {

	}

}
