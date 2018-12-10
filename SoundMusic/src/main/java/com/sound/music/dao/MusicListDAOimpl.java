package com.sound.music.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sound.music.vo.MusicInfoVO;
import com.sound.music.vo.NoticeVO;

public class MusicListDAOimpl implements CommonBoardDAO {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public void create(NoticeVO vo) throws Exception {

	}

	@Override
	public void update(NoticeVO vo) throws Exception {

	}

	@Override
	public void delete(int no) throws Exception {

	}
	@Override
	public void increaseViewcnt(int no) throws Exception {	
	
	}

	@Override
	public List<NoticeVO> listAll() throws Exception {
		return null;
	}

	@Override
	public MusicInfoVO mRead(int no) throws Exception {
		return session.selectOne("musicinfo.minfo",no);
	}

	@Override
	public NoticeVO read(int no) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}
