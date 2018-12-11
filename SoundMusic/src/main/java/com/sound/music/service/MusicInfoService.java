package com.sound.music.service;

import java.util.ArrayList;
import java.util.List;

import com.sound.music.util.PageUtil;
import com.sound.music.vo.MusicInfoVO;

public interface MusicInfoService {
	
	//음악 상세보기
	public MusicInfoVO info(int no) throws Exception;
	//전체 음악리스트
	public List<MusicInfoVO> allList() throws Exception;
	//음악 추가
	public void create(MusicInfoVO vo)throws Exception;
	//음악 수정
	public void update(MusicInfoVO vo)throws Exception;
	//음악 삭제
	public void delete(int no)throws Exception;
	//페이징 기능
	public PageUtil getPageInfo(int nowPage) throws Exception;
}