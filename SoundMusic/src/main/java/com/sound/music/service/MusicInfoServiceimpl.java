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
	
	//음악 상세보기
	@Override
	public MusicInfoVO info(int no) throws Exception {
		//MusicInfoVO result=musicDAO.info(no);
		return musicDAO.info(no);
	}
	
	//음악 전체 리스트
	@Override
	public List<MusicInfoVO> allList() throws Exception {
		
		return musicDAO.allList();
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
				
				//한페이지당 3개의 게시물을 뿌리고, 5페이지씩 보여주자
				PageUtil pInfo= new PageUtil(nowPage, totalCount, 50, 5);
				return pInfo;
	}

}
