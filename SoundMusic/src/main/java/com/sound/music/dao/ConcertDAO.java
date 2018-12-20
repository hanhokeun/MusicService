package com.sound.music.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.vo.ConcertVO;

// 콘서트 게시판 관련 질의를 실행할 DAO 클래스
@Service
public class ConcertDAO{
	//Statement역할을 할 sqlSessionTemplate를 필요
	@Autowired
	private SqlSessionTemplate session;

	//게시물 총 개수 구하기 질의 실행 함수
	public int getTotalCount() {
		//스테이먼트 구하기 -> 질의실행
		int result=session.selectOne("concert.totalCount");

		return result;
	}
	
	//해당 페이지에 보여줄 게시물 정보 구하기 질의 실행 함수
	public ArrayList getConcertList(ConcertVO vo) {
		//스테이먼트 구하기 -> 질의실행
		return (ArrayList)session.selectList("concert.concertList",vo);
	}
	
	//상세보기 질의 명령 실행 함수
	public ConcertVO getConcertView(String cno) {
		System.out.println(cno);
		//스테이먼트 구하기 -> 질의실행
		return session.selectOne("concert.concertView",cno);
	}
	
	//관련콘서트 질의 명령 실행 함수
	public ArrayList relationConcert(String artist) {
		//스테이트먼트 구하기 -> 질의실행
		return (ArrayList) session.selectList("concert.relationConcert",artist);
	}
	
	//검색 결과 데이터 개수 구하기 질의 명령 실행함수
	public int searchCount(ConcertVO vo) {
		return (Integer)session.selectOne("concert.searchCount",vo);
	}
	
	//검색어에 따른 데이터 검색 질의 명령 실행함수
	//여러건이 들어오기 때문에 ArrayList
	public ArrayList concertSearch(ConcertVO vo) {
		return (ArrayList)session.selectList("concert.concertSearch",vo);
	}
	
	//개막예정 콘서트 목록보기
	public ArrayList concertSchedule() {
		return (ArrayList)session.selectList("concert.concertSchedule");
	}
}
