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
	
	//음악리스트
	@Override
	public List<MusicInfoVO> mList(MusicInfoVO vo) throws Exception {
		return session.selectList("musicinfo.listinfo",vo);
	}
	//음악상세정보
	@Override
	public MusicInfoVO info(int no) throws Exception {

		return session.selectOne("musicinfo.minfo",no);
	}
	//음악 추가
	@Override
	public void create(MusicInfoVO vo) throws Exception {
		session.insert("musicinfo.insertMusic",vo);
	}
	
	//상세보기 수정
	@Override
	public void update(MusicInfoVO vo) throws Exception {
		session.update("musicinfo.updateMusic", vo);
	}
	
	//음악 삭제
	@Override
	public void delete(int no) throws Exception {
		session.delete("musicinfo.deleteMusic", no);
	}
	
	//전체 데이터개수
	@Override
	public int getPageInfo(MusicInfoVO mvo) throws Exception {
		int result = session.selectOne("musicinfo.totalCount",mvo);
		return result;
	}
	
	//리뷰 추가
	@Override
	public void rvWrite(MusicInfoVO vo) throws Exception {		
		session.insert("musicinfo.reviewWrite", vo);
	}
	
	@Override
	//리뷰 보여주기
	public List<MusicInfoVO> rvList(MusicInfoVO rvo) throws Exception{
		return session.selectList("musicinfo.rvList",rvo);
	}
	
	//리뷰 개수
	@Override
	public int getRvPageInfo(int oriNo) throws Exception {
		int result = session.selectOne("musicinfo.rvTotalCount",oriNo);
		return result;
	}
	//리뷰 수정
	@Override
	public void rvModify(MusicInfoVO rvo) throws Exception {
		session.update("musicinfo.reviewUpdate",rvo);
	}
	
	//리뷰 삭제
	@Override
	public void rvDelete(int rvno) throws Exception {
		session.update("musicinfo.reviewDelete",rvno);
	}
	
	//추천 유효성 검사
	@Override
	public MusicInfoVO selectStar(MusicInfoVO vo) throws Exception {
			boolean permit = false;
			MusicInfoVO svo = new MusicInfoVO();
			String res = session.selectOne("musicinfo.selectStar", vo);
			System.out.println("[3]res="+res);
			if(res=="" || res == null) {
				permit = true;
				svo.setPermit(permit);
				res = session.selectOne("musicinfo.selectSlist",vo.getId());
				vo.setRes(res);
				return svo;
			}
			else {
				svo.setRes(res);
				svo.setPermit(permit);
				return svo;
			}
		
	}
	
	//추천수 증가
	@Override
	public void updateStar(int no) throws Exception {
		session.update("musicinfo.updateStar",no);
	}
	
	//추천곡 목록 수정
	@Override
	public void updateSlist(MusicInfoVO vo) throws Exception {
		session.update("musicinfo.updateSlist", vo);
	}
}
