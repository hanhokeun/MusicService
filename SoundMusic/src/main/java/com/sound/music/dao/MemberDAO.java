package com.sound.music.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

// 이 클래스는 myBatis 를 이용해서 필요한 질의명령을 실행
	// 그결과를 알려줄 DAO 클래스
	// myBatis를 처리하기 위해서 SqlSessionDaoSupport를 상속받아야 한다.
public class MemberDAO extends SqlSessionDaoSupport {

	// 자동주입용변수(statement 역할을 할 SqlSessionTemplate 필요)
	@Autowired
	private SqlSessionTemplate session;	
	
	public HashMap HashMapLoginProc(HashMap map) {
		//여러가지 변수가 필요하기때문에 map으로
		
		HashMap result=(HashMap)session.selectOne("member.LoginProc",map);
		//실행할 쿼리문은 무조건 문자형
		return result;
	}
}
