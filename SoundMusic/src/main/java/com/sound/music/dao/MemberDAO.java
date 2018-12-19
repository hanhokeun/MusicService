package com.sound.music.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;

import com.sound.music.vo.MemberVO;

public class MemberDAO extends SqlSessionDaoSupport {

	
	@Autowired
	private SqlSessionTemplate session;	
	
	//마이페이지 비밀번호변경
	public void changePw(MemberVO vo) {
		/*System.out.println("마이페이지 비밀번호변경DAO");*/
		session.update("changePw",vo);		
	}
	
	//마이페이지 회원탈퇴
	public void memberDrop(MemberVO vo) {
		/*System.out.println("회원탈퇴 dao");*/
		session.update("member.memberDrop",vo);
	}
	
	// 마이페이지 회원수정처리
	public void modifyPfProc(MemberVO vo) {
		/*System.out.println("회원수정처리DAO");*/
		session.update("member.modifyPfProc",vo);		
	}
	
	// 마이페이지
	public MemberVO proFile(MemberVO vo) {
		/*System.out.println("마이페이지 DAO="+vo);*/
		return (MemberVO)session.selectOne("member.proFile",vo);
	}	
	
	//회원 비밀번호 찾기
	public String pwSearch(MemberVO vo) {
		/*System.out.println("회원비밀번호찾기 DAO");
		System.out.println("DAO받은 PW값="+vo);		*/
		return session.selectOne("member.pwSearch",vo);
	}
	
	
	//회원 아이디 찾기
	public String idSearch(MemberVO vo) {
		/*System.out.println("회원아이디찾기 DAO");*/
		System.out.println("DAO받은ID값="+vo);		
		return session.selectOne("member.idSearch",vo);
	}
	
	
	//관리자 회원추방
	public void DeleteMember(String id) {
		session.update("member.deleteMember",id);		
		/*System.out.println("회원추방 DAO");*/
	}
	
	//회원검색어에 따른 데이터 검색 질의 명령 실행함수
	public ArrayList memberSearch(MemberVO vo) {
		return (ArrayList)session.selectList("member.memberSearch", vo);
	}
	
	//회원검색 결과 데이터 개수 구하기 질의 명령 실행함수
	public int searchCount(MemberVO vo) {
		return (Integer)session.selectOne("member.searchCount",vo);
	}
	
	//관리자 회원목록조회
	public ArrayList getMemberList(MemberVO vo) {		
		 return (ArrayList)session.selectList("member.memberList",vo); 
	}
	
	//회원수 구하기 페이징처리 
	public int getTotalCount() {						
		//질의문 실행
		int result = session.selectOne("member.totalCount");
		return result;
	}
	
	//회원가입처리	
	public int signProc(MemberVO vo) {
		/*System.out.println("회원가입DAO");*/
		return session.insert("member.signProc",vo);
	}
	
	
	// id중복체크
	public String getidcheck(@RequestBody String userid) {		
		/*System.out.println("MemberDAO getidcheck()함수 호출");*/	
		return session.selectOne("member.getid",userid);
		
	}
	
	//로그인처리
	public HashMap HashMapLoginProc(HashMap map) {		
		HashMap result=(HashMap)session.selectOne("member.LoginProc",map);
		return result;
	}
	
	
	
	
}
