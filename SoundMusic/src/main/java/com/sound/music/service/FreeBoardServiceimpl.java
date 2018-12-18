package com.sound.music.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.dao.FreeBoardDAO;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.FreeBoardVO;

@Service
public class FreeBoardServiceimpl implements FreeBoardService {

	@Autowired
	private FreeBoardDAO frDAO;
	
	//글 등록 
	@Override
	public void insertBoard(FreeBoardVO vo, HttpSession session, ArrayList list) throws Exception {
		String id = (String)session.getAttribute("UID");
		vo.setId(id);
		frDAO.insertBoard(vo,"board");
		System.out.println("질의문 실행 후 no 변수 값="+ vo.getNo() );
		for(int i=0; i<list.size() ; i++) {
			
			vo.setOriNo(vo.getNo());
			HashMap map = (HashMap)list.get(i);
			vo.setPath((String)map.get("path"));
			vo.setOriName((String)map.get("oriName"));
			vo.setSaveName((String)map.get("saveName"));
			vo.setLen((Long)map.get("len"));
		
			//질의 명령 실행
			frDAO.insertBoard(vo,"fileInfo");
		}
	}
	// 페이지 정보 구하는 함수
	@Override
	public PageUtil getPageInfo(int nowPage) throws Exception{
		int totalCount=frDAO.getTotalCount();
		
		PageUtil pInfo = new PageUtil(nowPage, totalCount,5,5);
		return pInfo;
	}
	// 보드 리스트 가져오는 함수
	@Override
	public ArrayList getBoardList(PageUtil pInfo)throws Exception {
		System.out.println("보드리스트 시작");
		int start = (pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		int end =  start + pInfo.getListCount()-1;
		FreeBoardVO vo = new FreeBoardVO();
		vo.setStart(start);
		vo.setEnd(end);
		ArrayList list = frDAO.getBoardList(vo);
		System.out.println("리스트 내용"+list);
		System.out.println("보드리스트 끝");
		return list;
	}
	// 상세보기 함수
	@Override
	public FreeBoardVO getBoardView(int oriNo) throws Exception{
		FreeBoardVO vo = frDAO.getBoardView(oriNo);
		return vo;
	}
	// 파일 상세보기 함수
	@Override
	public ArrayList getFileInfo(int oriNo)throws Exception {
		ArrayList list = frDAO.getFileInfo(oriNo);
		
		return list;
	}
	// 조회수 증가 함수
	@Override
	public void updateHit(int oriNo, HttpSession session) throws Exception{
		boolean isHit = false;// 조회수 증가를 할지 말지 기억할 변수.
		ArrayList hitList = (ArrayList)session.getAttribute("HIT");
		
		if(hitList==null||hitList.size()==0){//첫방문
			hitList = new ArrayList();
			hitList.add(oriNo);
			isHit=true;
			session.setAttribute("HIT", hitList);
			
		}else if(!hitList.contains(oriNo)){//첫방문은 아니지만 해당 글은 처음
			
			hitList.add(oriNo);
			isHit=true;
			session.setAttribute("HIT", hitList);
			
		}else {
			isHit = false;
		}
		if(isHit == true) {
			frDAO.updateHit(oriNo);
		}
	}
	//파일 다운로드 함수
	@Override
	public FreeBoardVO getDownloadFile(int fileNo) throws Exception{
		FreeBoardVO vo = frDAO.getDownload(fileNo);
		return vo;
	}
	//글수정 함수..
	@Override
	public void updateBoard(FreeBoardVO vo, ArrayList list)throws Exception{
		frDAO.updateBoard(vo, "free");
		
		for(int i=0;i<list.size();i++) {
			//파일에 대한 정보를 list가 가지고 있고 파일 한개당 정보는 Map이 가지고 있음
			//map의 정보를 활용해서 vo에 담아 실행시켜 줄 수 있도록 함
			System.out.println("list size:"+list.size());
			vo.setOriNo(vo.getOriNo());
			HashMap map = (HashMap)list.get(i);
			vo.setPath((String)map.get("path"));
			vo.setOriName((String)map.get("oriName"));
			vo.setSaveName((String)map.get("saveName"));
			vo.setLen((Long)map.get("len"));
			frDAO.updateBoard(vo, "file");//파일 정보 등록 질의 실행
		}
	}
	//글 삭제 명령 실행함수
	@Override
	public int deleteBoard(int oriNo) {
		System.out.println("서비스 시작");
		int cnt = frDAO.deleteBoard(oriNo);
		System.out.println("서비스 종료");
		return cnt;
	}
	
}


	
