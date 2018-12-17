package com.sound.music.service;

import java.util.ArrayList;
import java.util.List;

import com.sound.music.util.PageUtil;
import com.sound.music.util.RVPage;
import com.sound.music.vo.MusicInfoVO;

public interface MusicInfoService {
	
	//음악 상세보기
	public MusicInfoVO info(int no) throws Exception;
	//전체 음악리스트
	public List<MusicInfoVO> mList(PageUtil pInfo, MusicInfoVO mvo) throws Exception;
	//음악 추가
	public void create(MusicInfoVO vo)throws Exception;
	//음악 수정
	public void update(MusicInfoVO vo)throws Exception;
	//음악 삭제
	public void delete(int no)throws Exception;
	//페이징 기능
	public PageUtil getPageInfo(int nowPage, MusicInfoVO mvo) throws Exception;
	//리뷰 추가
	public void rvWrite(MusicInfoVO vo)throws Exception;
	//리뷰 상세
	public List<MusicInfoVO> rvList(RVPage rPage, int no)throws Exception;
	//리뷰 개수구하기
	public RVPage getRvPageInfo(int rvPage, int no)throws Exception;
	//리뷰 수정하기
	public void rvModify(MusicInfoVO rvo)throws Exception;
	//리뷰 삭제하기
	public void rvDelete(int rvno)throws Exception;
}