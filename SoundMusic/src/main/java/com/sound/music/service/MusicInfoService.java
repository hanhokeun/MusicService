package com.sound.music.service;

import java.util.ArrayList;

import com.sound.music.vo.MusicInfoVO;

public interface MusicInfoService {
	
	//음악 상세보기
	public MusicInfoVO info(int no) throws Exception;
	//전체 음악리스트
	public MusicInfoVO allList(ArrayList list) throws Exception;
	//음악 추가
	public void create(MusicInfoVO vo)throws Exception;
	//음악 수정
	public void update(MusicInfoVO vo)throws Exception;
	//음악 삭제
	public void delete(int no)throws Exception;
}
