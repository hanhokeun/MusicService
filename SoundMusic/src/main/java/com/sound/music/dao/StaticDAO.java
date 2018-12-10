package com.sound.music.dao;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.vo.StaticVO;

@Service("staticDAO")
public class StaticDAO implements StaticInter {

	@Autowired
	private SqlSessionTemplate session;
	//게시글 입력하기
	public void insertStatic(StaticVO vo, String kind) {
		if(kind.equals("static")) {
			//게시판 글쓰기 처리
			session.insert("staticBoard.insertStatic",vo);
		}else if(kind.equals("file")){
			session.insert("fileBoard.insertFile",vo);
		}
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
