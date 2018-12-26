package com.sound.music.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.dao.ConcertDAO;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.ConcertVO;

//서비스 클래스
@Service
public class ConcertService {

	@Autowired
	private ConcertDAO cDAO;
	
	//페이지 이동 정보를 만들어주는 함수
	public PageUtil getPageInfo(int nowPage) {
		//할일
		//게시물 총 개수 구하기 질의 실행 함수
		int totalCount=cDAO.getTotalCount();
		
		//한 페이지당 15개의 게시물을 뿌리고, 10페이지씩 보여주자
		PageUtil pInfo=new PageUtil(nowPage, totalCount, 15, 10);
		
		return pInfo;
	}
	
	//게시물 정보 구하기 함수
	public ArrayList getConcertList(PageUtil pInfo) {
		
		//그 페이지에서 필요한 시작위치와 마지막 위치를 계산하자
		/* 보고싶은페이지	start	end
		 * 1페이지		1		10
		 * 2			11		20
		 */
		
		//시작페이지= (현재페이지-1)*(한 페이지에 보여줄 게시물수)
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		
		//끝페이지= 시작페이지 + 그 페이지에서 보여줄 게시물수-1
		int end=start + pInfo.getListCount()-1;
		
		ConcertVO vo = new ConcertVO();
		vo.setStart(start);
		vo.setEnd(end);
		
		//질의 실행
		ArrayList list = cDAO.getConcertList(vo);
		
		return list;
	}
	
	//상세보기 처리 함수
	public ConcertVO getConcertView(String oriNo) {
		ConcertVO vo = cDAO.getConcertView(oriNo);
		return vo;
	}
	
	//관련콘서트 보기 처리 함수
	public ArrayList getrelationConcert(String artist) {
		ArrayList list = cDAO.relationConcert(artist);
		return list;
	}
	
	//검색 결과 데이터 개수 구하기 호출 함수
	public PageUtil getSearchPage(ConcertVO vo, int nowPage) {
		//총 데이터 개수구하기
		int count = cDAO.searchCount(vo);
		
		//페이지이동정보
		PageUtil pInfo = new PageUtil(nowPage, count, 15, 10);
		return pInfo;
	}
	
	//검색어에 따른 데이터 검색 호출 함수
	public ArrayList concertSearch(ConcertVO vo, PageUtil pInfo) {
		//페이지에서 보여줄 시작~끝 알아내기
		//시작페이지
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		
		//끝페이지
		int end=start + pInfo.getListCount()-1;
		
		vo.setStart(start);
		vo.setEnd(end);
		
		//DB에서 질의를 실행할 때 필요한 데이터를 주고 결과 받기
		ArrayList list = cDAO.concertSearch(vo);
		return list;
	}
	
	//개막예정 콘서트 목록보기
		public ArrayList concertSchedule() {
			ArrayList list2 = cDAO.concertSchedule();
			return list2;
		}
}
