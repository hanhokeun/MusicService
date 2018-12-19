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
			String id = vo.getId();
			MusicInfoVO svo = new MusicInfoVO();
			//먼저 들어온 vo로 유효성 검사를 하자
			 int cnt = session.selectOne("musicinfo.selectStar", vo);
			 //1.추천곡 번호가 포함 되어있지 않으면
			 if(cnt == 0){
				 permit = true; // 추천 가능
				 //이 유저의 추천곡 리스트를 불러오자
				 MusicInfoVO tempvo = new MusicInfoVO();
				 tempvo.setId(id);
				 String res = session.selectOne("musicinfo.selectSlist",tempvo);
				 svo.setRes(res);
				 svo.setPermit(permit);
				 return svo;
				}
			 //2.추천곡 번호가 포함되어 있다면
			else {
				 MusicInfoVO tempvo = new MusicInfoVO();
				 tempvo.setId(id);
				 //이 유저의 추천곡 리스트도 담아오자
				 String res = session.selectOne("musicinfo.selectSlist",tempvo);
				 svo.setPermit(permit); // 추천 불가
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
	
	//삭제곡 목록
	@Override
	public List<MusicInfoVO> rcList(MusicInfoVO vo) throws Exception {
		return session.selectList("musicinfo.recycleInfo",vo);
	}
	
	//삭제음악 개수
	@Override
	public int getrcPageInfo(String genre) throws Exception {
		MusicInfoVO vo = new MusicInfoVO();
		vo.setGenre(genre);
		int result = session.selectOne("musicinfo.rcyCount",vo);
		return result;
	}
	
	//음악 복원
	@Override
	public void recycleMusic(int no) throws Exception {
		session.update("musicinfo.recycleMusic", no);
	}
}
