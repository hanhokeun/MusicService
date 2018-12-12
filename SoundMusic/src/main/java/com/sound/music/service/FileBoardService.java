package com.sound.music.service;



import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.dao.FileBoardDAO;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.FileBoardVO;


//서비스 클래스
//DAO에 접근해서 DAO를 호출
@Service
public class FileBoardService {
	
	@Autowired
	private FileBoardDAO fDAO;
	
	//게시물정보를 DB에 기록할 함수
	public void insertBoard(FileBoardVO vo,HttpSession session,ArrayList list) {
		System.out.println("질의문 실행하기 전의 no 변수값 ="+vo.getNo());
		String id = (String)session.getAttribute("UID");
		//질의명령을 실행할 때 필요한 데이터는 vo로 묶어서 알려주기로 했으므로
		vo.setId(id);
		
		
		//할일
		// 게시물을 등록
		fDAO.insertBoard(vo, "board");
		
		System.out.println("질의문  실행 후의 no 변수값 ="+vo.getNo());
		
		//업로드된 파일정보를 등록.
		//파일의 정보는 list가 가지고 있는 개수만큼 처리되어야한다.
		for(int i=0;i<list.size();i++) {	
			
			//질의문을 실행할때 필요한 모든 정보는 vo를 이용해서 알려주기로 했으므로
			vo.setOriNo(vo.getNo());
			//파일에 대한 정보는 list가 가지고 있고, 
			//하나의 파일에대한 정보는 map 으로 보냈다.
			HashMap map = (HashMap)list.get(i);
			vo.setPath((String)map.get("path"));
			vo.setOriName((String)map.get("oriName"));
			vo.setSaveName((String)map.get("saveName"));
			vo.setLen((Long)map.get("len"));
			
			//질의명령실행
			fDAO.insertBoard(vo, "fileInfo");
		}

	
	
	}
	//페이지 이동 정보를 만들어주는 함수
	public PageUtil getPageInfo(int nowPage) {
		//할일
		//게시물 총개수 구하기 
		int totalCount = fDAO.getTotalCount();
		// 한페이지당 3개의 게시물을 뿌리고, 5페이지씩 보여준다.
		PageUtil pinfo = new PageUtil(nowPage, totalCount, 3, 5);
		
		return pinfo;
	
	}
	//게시물 정보구하기 함수
	public ArrayList getBoardList(PageUtil pInfo){
		//parameter 가 pageutil이 된 이유는 페이지에 필요한 목록을 구해야하는데
		//이때 #{start}, #{end}를 채워 줘야 한다. 문제는 이정보는 보고싶은 페이지에 따라서 
		//달라지기 때문에 필요하다.
		
		//그 페이지에서 필요한 시작위치와 마지막 위치를 계산하자.
		
		
		//페이지에 대한 정보도 같이 담아서 처리해줘야한다.
		//시작
		int start = (pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		//끝
		int end = start + pInfo.getListCount()-1;
		FileBoardVO vo =new FileBoardVO();
		vo.setStart(start);
		vo.setEnd(end);
		
		//질의문 실행
		ArrayList list = fDAO.getBoardList(vo);
		return list;
		
	}
	
	
}
