package com.sound.music.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.dao.MusicDAO;
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

}
