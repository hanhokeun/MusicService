package com.sound.music.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.dao.StaticDAO;

import com.sound.music.service.StaticServiceInter;
import com.sound.music.util.PageUtil;

import com.sound.music.vo.StaticVO;

@Service
public class StaticService implements StaticServiceInter {

	@Autowired
	private StaticDAO sDAO;
	//페이지정보 구하기
	@Override
	public PageUtil getPageInfo(int nowPage)throws Exception {
		//sDAO.
		return null;
	}
	//통계 글 목록보여주기
	@Override
	public ArrayList<StaticVO> List() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	//통계 글 조회수 증가하기
	@Override
	public void increaseHit(int no) throws Exception {
		// TODO Auto-generated method stub
		
	}
	//댓글 등록
	@Override
	public StaticVO insertReply(int oriNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	//댓글 수정
	@Override
	public void updateReply(StaticVO vo) throws Exception {
		// TODO Auto-generated method stub
		
	}
	//댓글 삭제
	@Override
	public void deleteReply(int no) throws Exception {
		// TODO Auto-generated method stub
		
	}

	//글쓰기 정보 등록처리
	@Override
	public void insertStatic(StaticVO vo, HttpSession session,ArrayList list)throws Exception {
		//게시글 등록
		sDAO.insert(vo, "static");
		//파일 정보 등록
		for(int i=0;i<list.size();i++) {
			//파일에 대한 정보를 list가 가지고 있고 파일 한개당 정보는 Map이 가지고 있음
			//map의 정보를 활용해서 vo에 담아 실행시켜 줄 수 있도록 함
			vo.setOriNo(vo.getNo());
			HashMap map = (HashMap)list.get(i);
			vo.setPath((String)map.get("path"));
			vo.setOriName((String)map.get("oriName"));
			vo.setSaveName((String)map.get("saveName"));
			vo.setLen((Long)map.get("len"));
			sDAO.insert(vo, "file"); //파일 정보 등록 질의 실행
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