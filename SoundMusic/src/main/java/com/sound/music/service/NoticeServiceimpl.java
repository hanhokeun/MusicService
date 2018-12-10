package com.sound.music.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.dao.CommonBoardDAO;
import com.sound.music.vo.NoticeVO;

@Service
public class NoticeServiceimpl implements CommonBoardService {
	
	@Autowired
	CommonBoardDAO noticeDao;
	//01. 게시글 쓰기
	@Override
	public void create(NoticeVO vo) throws Exception {
		String title = vo.getTitle();
		String content = vo.getContent();
		String writer = vo.getWriter();
		//* 태그문자 처리 (< ->&lt; > -> &gt;)
		// replace(A,B) A를 B로 변경
		title =title.replace("<", "&lt");
		title =title.replace(">", "&gt");
		writer =writer.replace("<", "&lt");
		writer =writer.replace(">", "&gt");
		//* 공백 문자 처리
		title =title.replace(" ", "&nbsp;&nbsp;");
		writer =writer.replace(" ", "&nbsp;&nbsp;");
		//* 줄바꿈 문자 처리 
		content = content.replaceAll("\n", "<br>");
		vo.setTitle(title);
		vo.setContent(content);
		vo.setWriter(writer);
		noticeDao.create(vo);
		
		
	}
	//02. 게시글 상세보기
	@Override
	public NoticeVO read(int no) throws Exception {
		
		return  noticeDao.read(no);
	}
	//03.게시글 수정
	@Override
	public void update(NoticeVO vo) throws Exception {
		noticeDao.update(vo);
		
	}
	//04. 게시글 삭제
	@Override
	public void delete(int no) throws Exception {
		noticeDao.delete(no);
		
	}
	//05. 게시글 전체 목록
	@Override
	public List<NoticeVO> listAll() throws Exception {
		
		return  noticeDao.listAll();
	}
	//06. 게시글 조회수 증가.
	@Override
	public void increaseViewcnt(int no, HttpSession session) throws Exception {
		long update_time = 0;
		//세션에 저장된 조회시간 검색
		// 최초로 조회할 경우 세션에 저장된 값이 없기 때문에 if문은 실행되지 않음
		if(session.getAttribute("update_time_"+no)!= null) {
			//세션에서 읽어오기
			update_time = (Long) session.getAttribute("update_time_"+no);
		}
		//시스템의 현재시간을 current_time에 저장
		long current_time = System.currentTimeMillis();
		//일정시간이 경과후 조회수 증가 처리 24*60*60*1000(24시간)
		//시스템 현재 시간 -열람시간 > 일정시간(조회수 증가가 가능하도록 지정한 시간)
		if(current_time - update_time > 5*1000) {
			noticeDao.increaseViewcnt(no);
			//세션에 시간을 저장 : "update_time_"+no는 다른 변수와 중복되지 않게 명명
			session.setAttribute("update_time_"+no, current_time);
		}
		
	}

	
}
