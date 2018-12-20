package com.sound.music.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.dao.StaticDAOInter;
import com.sound.music.service.StaticServiceInter;
import com.sound.music.util.PageUtil;
import com.sound.music.util.RVPage;
import com.sound.music.vo.StaticVO;

@Service
public class StaticService implements StaticServiceInter {

	@Autowired
	private StaticDAOInter sDAO;
	//통계 글 조회수 증가하기
	@Override
	public void increaseHit(int oriNo,HttpSession session) throws Exception {
		boolean isHit=false;
		ArrayList hitList = (ArrayList)session.getAttribute("HIT");
		if(hitList==null||hitList.size()==0) { //글 한번도 안본사람
			isHit=true;
			hitList = new ArrayList();
			hitList.add(oriNo);
			session.setAttribute("HIT",hitList);
		}else if(!hitList.contains(oriNo)) { //다른 글만 본사람
			isHit=true;
			hitList.add(oriNo);
			session.setAttribute("HIT",hitList);
		}else { //해당 글을 본 사람
			isHit=false;
		}
		if(isHit==true) { //글을 보지 않은 사람만
			sDAO.increaseHit(oriNo); //조회수 증가
		}
	}
	//게시글의 파일정보 보기
	@Override
	public ArrayList selectFileInfo(int oriNo) throws Exception {
		ArrayList list = sDAO.selectFileInfo(oriNo);
		return list;
	}
	//댓글 페이징 처리
	@Override
	public RVPage getRvPageInfo(int rvPage, int oriNo) throws Exception {
		int rvCount = sDAO.getRvTotalCount(oriNo);
		RVPage rPage = new RVPage(rvPage,rvCount,3,3);
		return rPage;
	}
	//댓글 조회하기
	@Override
	public ArrayList selectReply(RVPage rPage,int oriNo) throws Exception {
		//시작
		int start=(rPage.getRvPage()-1)*rPage.getListCount()+1;
		int end=start+rPage.getListCount()-1;
		StaticVO vo = new StaticVO();
		vo.setStart(start);
		vo.setEnd(end);
		vo.setOriNo(oriNo);		
		ArrayList list = sDAO.selectReply(vo);
		return list;
	}
	//댓글 등록
	@Override
	public void insertReply(StaticVO vo) throws Exception {
		sDAO.insertReply(vo);
	}
	//댓글 수정
	@Override
	public void updateReply(StaticVO vo) throws Exception {
		sDAO.updateReply(vo);
	}
	//댓글 삭제
	@Override
	public void deleteReply(StaticVO vo) throws Exception {
		sDAO.deleteReply(vo);
	}
	//글쓰기 정보 등록처리
	@Override
	public void insertStatic(StaticVO vo, ArrayList list) throws Exception {
		//게시글 등록
		sDAO.insert(vo, "static");
		//파일 정보 등록
		for(int i=0;i<list.size();i++) {
			//파일에 대한 정보를 list가 가지고 있고 파일 한개당 정보는 Map이 가지고 있음
			//map의 정보를 활용해서 vo에 담아 실행시켜 줄 수 있도록 함
			System.out.println("list size:"+list.size());
			vo.setOriNo(vo.getNo());
			HashMap map = (HashMap)list.get(i);
			vo.setPath((String)map.get("path"));
			vo.setOriName((String)map.get("oriName"));
			vo.setSaveName((String)map.get("saveName"));
			vo.setLen((Long)map.get("len"));
			sDAO.insert(vo, "file"); //파일 정보 등록 질의 실행
		}
	}
	//글 수정하기에서 파일 업로드,글 수정
	@Override
	public void update(StaticVO vo,ArrayList list) throws Exception {
		sDAO.update(vo,"static");
		System.out.println("title:"+vo.getTitle());
		System.out.println("body:"+vo.getBody());
		System.out.println("artist:"+vo.getArtist());
		System.out.println("song:"+vo.getSong());
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
			sDAO.update(vo, "file");//파일 정보 등록 질의 실행
		}
	}
	//글쓰기 상세 글보기
	@Override
	public StaticVO detail(int oriNo) throws Exception {
		StaticVO vo = sDAO.detail(oriNo);
		return vo;
	}
	//통계 글 삭제하기
	@Override
	public void delete(int oriNo) throws Exception {
		sDAO.delete(oriNo);
	}
	//통계글 삭제하면서 파일도 삭제하기
	@Override
	public void deleteAllFile(int oriNo) throws Exception {
		sDAO.deleteAllFile(oriNo);
	}
	//다운로드 or 삭제할 파일 정보 검색하기
	@Override
	public StaticVO downNDelFile(int fileNo) throws Exception {
		StaticVO vo = sDAO.downNDelFile(fileNo);
		return vo;
	}
	//다운로드 횟수 증가시키기
	@Override
	public void downloadCount(int fileNo) throws Exception {
		sDAO.downloadCount(fileNo);
	}
	//원글의 첨부 파일 삭제하기
	@Override
	public void deleteFile(int fileNo) throws Exception {
		sDAO.deleteFile(fileNo);
	}
	//목록에서 검색하기
	@Override
	public ArrayList<StaticVO> SearchList(PageUtil pInfo,StaticVO vo) throws Exception {
		int start = (pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		int end = start+pInfo.getListCount()-1;
		vo.setStart(start);
		vo.setEnd(end);
		System.out.println("start="+start);
		System.out.println("end="+end);
		ArrayList list = sDAO.SearchList(vo);
		return list;
	}
	//통계 게시글 검색 결과 페이징 처리 
	@Override
	public PageUtil totalCount(int nowPage,StaticVO vo) throws Exception {
		int totalCount = sDAO.totalCount(vo);
		System.out.println("totalCount="+totalCount);
		System.out.println("nowPage"+nowPage);
		PageUtil pInfo = new PageUtil(nowPage,totalCount,6,3);
		return pInfo;
	}
}