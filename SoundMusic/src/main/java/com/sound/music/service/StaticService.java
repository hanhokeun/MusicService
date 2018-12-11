package com.sound.music.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.sound.music.dao.StaticDAO;
import com.sound.music.service.StaticServiceInter;
import com.sound.music.vo.StaticVO;

public class StaticService implements StaticServiceInter {

	@Autowired
	private StaticDAO sDAO;
	//글쓰기 정보 처리하기
	public void insertStatic(StaticVO vo, HttpSession session,ArrayList list) {
		//게시글 등록
		sDAO.insertStatic(vo, "static");
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
			sDAO.insertStatic(vo, "file"); //파일 정보 등록 질의 실행
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