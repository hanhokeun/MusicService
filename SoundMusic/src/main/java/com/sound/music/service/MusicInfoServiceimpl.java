package com.sound.music.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sound.music.dao.MusicDAO;
import com.sound.music.util.PageUtil;
import com.sound.music.util.RVPage;
import com.sound.music.vo.MusicInfoVO;

@Service
public class MusicInfoServiceimpl implements MusicInfoService {
	
	@Autowired
	MusicDAO musicDAO;
	//음악리스트
	@Override
	public List<MusicInfoVO> mList(PageUtil pInfo, MusicInfoVO mvo) throws Exception {
		//시작 = (현재페이지-1)*(한 페이지에 보여줄 게시물 수)
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		//끝 = 시작페이지 + 그 페이지에서 보여줄 게시물수-1
		int end=start + pInfo.getListCount()-1;
		MusicInfoVO vo = new MusicInfoVO();
		vo.setGenre(mvo.getGenre());
		vo.setSub(mvo.getSub());
		vo.setSvalue(mvo.getSvalue());
		vo.setStart(start);
		vo.setEnd(end);
		return musicDAO.mList(vo);
	}
	
	//음악 상세보기
	@Override
	public MusicInfoVO info(int no) throws Exception {
		//MusicInfoVO result=musicDAO.info(no);
		return musicDAO.info(no);
	}
	//음악 추가
	@Override
	public void create(MusicInfoVO vo) throws Exception {
		musicDAO.create(vo);
	}
	
	//상세보기 수정
	@Override
	public void update(MusicInfoVO vo) throws Exception {
		musicDAO.update(vo);
	}
	
	//음악 삭제
	@Override
	public void delete(int no) throws Exception {
		musicDAO.delete(no);
	}
	
	//페이징기능
	@Override
	public PageUtil getPageInfo(@RequestParam(value="nowPage",defaultValue="1") int nowPage, MusicInfoVO mvo) throws Exception {
		//할일
				//게시물 총 개수 구하기
				int totalCount= musicDAO.getPageInfo(mvo);
				
				//한페이지당 50개의 게시물을 뿌리고, 5페이지씩 보여주자
				PageUtil pInfo= new PageUtil(nowPage, totalCount, 30, 5);
				return pInfo;
	}
	
	//리뷰 추가
	@Override
	public void rvWrite(MusicInfoVO vo) throws Exception {
		musicDAO.rvWrite(vo);
	}
	
	//리뷰 보여주기
	@Override
	public List<MusicInfoVO> rvList(RVPage rPage, int no) throws Exception {
		//시작 = (현재페이지-1)*(한 페이지에 보여줄 게시물 수)
		int start=(rPage.getRvPage()-1)*rPage.getListCount()+1;
		//끝 = 시작페이지 + 그 페이지에서 보여줄 게시물수-1
		int end=start + rPage.getListCount()-1;
		int oriNo = no;
		MusicInfoVO rvo = new MusicInfoVO();
		rvo.setOriNo(oriNo);
		rvo.setStart(start);
		rvo.setEnd(end);
		return musicDAO.rvList(rvo);	
	}
	
	//리뷰 페이징
	@Override
	public RVPage getRvPageInfo(@RequestParam(value="rvPage",defaultValue="1") int rvPage, int no) throws Exception {
		int oriNo = no;
		int rvCount =  musicDAO.getRvPageInfo(oriNo);
		RVPage rPage= new RVPage(rvPage, rvCount, 5, 5);
		
		return rPage;
	}
	
	//리뷰 수정
	@Override
	public void rvModify(MusicInfoVO rvo) throws Exception {
		musicDAO.rvModify(rvo);
	}
	//리뷰 삭제
	@Override
	public void rvDelete(int rvno) throws Exception {
		musicDAO.rvDelete(rvno);
	}
	
	//추천 유효성 검사
	@Override
	public MusicInfoVO selectStar(String id, String strNo) throws Exception {
		MusicInfoVO vo = new MusicInfoVO();
		vo.setId(id);
		vo.setStrNo(strNo);
		return musicDAO.selectStar(vo);	 
	}
	
	//추천수 증가
	@Override
	public void updateStar(int no) throws Exception {
		musicDAO.updateStar(no);
	}
	
	//추천곡 리스트 추가
	@Override
	public void updateSlist(String res, String id) throws Exception {
		MusicInfoVO vo = new MusicInfoVO();
		vo.setRes(res);
		vo.setId(id);
		musicDAO.updateSlist(vo);
	}
	
	//삭제된 곡 리스트
	@Override
	public List<MusicInfoVO> rcList(PageUtil pInfo, String genre) throws Exception {
		//시작 = (현재페이지-1)*(한 페이지에 보여줄 게시물 수)
			int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
			//끝 = 시작페이지 + 그 페이지에서 보여줄 게시물수-1
			int end=start + pInfo.getListCount()-1;
			MusicInfoVO vo = new MusicInfoVO();
			vo.setGenre(genre);
			vo.setStart(start);
			vo.setEnd(end);
			return musicDAO.rcList(vo);
	}
	//삭제된 곡 페이징
	@Override
	public PageUtil getrcPageInfo(@RequestParam(value="nowPage",defaultValue="1") int nowPage, String genre) throws Exception {
		//할일
		//게시물 총 개수 구하기
		int totalCount= musicDAO.getrcPageInfo(genre);
		
		//한페이지당 20개의 게시물을 뿌리고, 5페이지씩 보여주자
		PageUtil pInfo= new PageUtil(nowPage, totalCount, 20, 5);
		return pInfo;
	}
	
	//음악 복원
	@Override
	public void recycleMusic(int no) throws Exception {
		musicDAO.recycleMusic(no);
	}

	
	


}
