package com.sound.music.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.vo.NoticeVO;

@Service		//현재 클래스를 DAO bean으로 등록
public class NoticeDAOimpl implements CommonBoardDAO {
	@Autowired
	SqlSession SqlSession;
	//01.게시글 작성
	@Override
	public void create(NoticeVO vo)throws Exception{
		SqlSession.insert("notice.insert",vo);
	}
	//02. 게시글 상세
	@Override
	public NoticeVO read(int no) throws Exception {
		
		return SqlSession.selectOne("notice.view",no);
	}
	//03.게시글 수정
	@Override
	public void update(NoticeVO vo) throws Exception {
				SqlSession.update("notice.updateArticle",vo);
	}
	//04.게시글 삭제
	@Override
	public void delete(int no) throws Exception {
				SqlSession.delete("notice.deleteArticle",no);
	}
	//05.게시글 전체 목록
	@Override
	public List<NoticeVO> listAll() throws Exception {
		
		return SqlSession.selectList("notice.lisAll");
	}
	//06.게시글 조회수 증가
	@Override
	public void increaseViewcnt(int no) throws Exception {
		SqlSession.update("notice.increaseViewcon", no);
		
	}

}
