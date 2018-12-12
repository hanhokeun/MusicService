package com.sound.music.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sound.music.dao.MusicDAO;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.MusicInfoVO;

@Service
public class MusicInfoServiceimpl implements MusicInfoService {
	@Autowired
	MusicDAO musicDAO; 
	
	//음악리스트
	@Override
	public List<MusicInfoVO> mList(String genre, PageUtil pInfo) throws Exception {
		//시작 = (현재페이지-1)*(한 페이지에 보여줄 게시물 수)
		int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
		//끝 = 시작페이지 + 그 페이지에서 보여줄 게시물수-1
		int end=start + pInfo.getListCount()-1;
		MusicInfoVO vo = new MusicInfoVO();
		vo.setGenre(genre);
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

	@Override
	public void create(MusicInfoVO vo) throws Exception {
	}

	@Override
	public void update(MusicInfoVO vo) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int no) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public PageUtil getPageInfo(@RequestParam(value="nowPage",defaultValue="1") int nowPage) throws Exception {
		//할일
				//게시물 총 개수 구하기
				int totalCount= musicDAO.getPageInfo();
				
				//한페이지당 50개의 게시물을 뿌리고, 5페이지씩 보여주자
				PageUtil pInfo= new PageUtil(nowPage, totalCount, 50, 5);
				return pInfo;
	}



}
