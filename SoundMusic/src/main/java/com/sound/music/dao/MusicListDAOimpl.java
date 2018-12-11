package com.sound.music.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.util.PageUtil;
import com.sound.music.vo.MusicInfoVO;
import com.sound.music.vo.NoticeVO;

@Service
public class MusicListDAOimpl implements MusicDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
	//음악상세정보
	@Override
	public MusicInfoVO info(int no) throws Exception {

		return session.selectOne("musicinfo.minfo",no);
	}
	
	//음악 리스트
	@Override
	public List<MusicInfoVO> allList() throws Exception {
		return session.selectList("musicinfo.listinfo");
	}

	@Override
	public void create(MusicInfoVO vo) throws Exception {
		// TODO Auto-generated method stub
		
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
	public int getPageInfo() throws Exception {
		int result = session.selectOne("musicinfo.totalCount");
		return result;
	}

	
}
