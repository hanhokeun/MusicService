package com.sound.music.dao;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.util.PageUtil;
import com.sound.music.vo.StaticVO;

@Service("staticDAO")
public class StaticDAO implements StaticDAOInter {

	@Autowired
	private SqlSessionTemplate session;
	//게시글 페이지 정보 구하기
	@Override
	public PageUtil getPageInfo(int nowPage) throws Exception{
		return null;
	}
	//게시글 입력하기
	@Override
	public void insert(StaticVO vo, String kind) {
		if(kind.equals("static")) {
			//게시판 글쓰기 처리
			session.insert("staticBoard.insertStatic",vo);
		}else if(kind.equals("file")){
			session.insert("fileBoard.insertFile",vo);
		}
	}
	
	@Override
	public ArrayList<StaticVO> List() throws Exception {
		return null;
	}

	@Override
	public void increaseHit(int no) throws Exception {
		
	}

	@Override
	public StaticVO reply(int oriNo) throws Exception {
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
