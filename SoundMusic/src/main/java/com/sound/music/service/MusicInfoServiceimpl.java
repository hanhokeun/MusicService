package com.sound.music.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.dao.MusicDAO;
import com.sound.music.vo.MusicInfoVO;

@Service
public class MusicInfoServiceimpl implements MusicInfoService {
	@Autowired
	MusicDAO musicDAO; 
	
	@Override
	public MusicInfoVO info(int no) throws Exception {
		
		return null;
	}

	@Override
	public MusicInfoVO allList(ArrayList list) throws Exception {
		
		return null;
	}

	@Override
	public void create(MusicInfoVO vo) throws Exception {
		System.out.println("musicAdd");
		musicDAO.create(null);
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
