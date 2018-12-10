package com.sound.music.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sound.music.vo.MemberVO;
import com.sound.music.dao.MemberDAO;


// 이 클래스는 서비스 기능을 담당하는 클래스
	// 서비스 클래스를 따로 만들어서 처리하는 이유?
	// -모듈화(클라이언트의 여러요청안에 공통적인 내용이 있으므로)
	// 	여러 요청컨트롤러에서 필요할때마다 사용할 수 있게한다.
	// 가끔은 @Service 선언하여 서비스 클래스를 이용하기도 한다.

@Service
public class MemberService {

		// 이 서비스 함수는 비즈니스 로직을 처리하기위한 함수선언
		@Autowired
		private MemberDAO mDAO;
	
		// 로그인처리 함수(함수명 상관없다.)
		public void loginProc(MemberVO vo,HttpSession session) { //MemberVo에서 데이터를 끄집어낸다.
			// 파라미터 필요
			// VO 를 받는 이유?
			// 로그인을 하기 위해서는 입력한 id 와 pw를 알아야 하므로 
			// MemberVO vo로 매개변수로 받는다.
			// HttpSession 를 받은 이유 는 로그인하면 세션을 이용하여 로그인 처리목적
			
			// 할일 1. DB에서 로그인 입력값을 이용하여 회원여부를 얻어낸다.
			// -> DAO 가 필요하다.
			
			//질의문을 실행할 때 필요한 정보는 Map으로 알려주기로 했으므로
			// Map 에 필요한 정보를 넣어서 알려줘야 한다.
			HashMap map = new HashMap();
			
			map.put("id",vo.getId());
			map.put("pw", vo.getPw());
			// map으로 데이터를 넣을때 주의점
			// 맵은 key 와 value 로 이루어져 있기때문에 
			// DAO 에서 실행되는 SQL문에 #{}안에 있는 변수로 사용되어진다.
			// SQL 명령안의 ${적당한값}부분의 적당한 값이 Map의 키 값이 되어진다.
			// 대소문 스펠링까지 주의해서 처리해야된다.
			
			//MemberDAO의 HashMap HashMapLoginProc(HashMap map) 호출
			// 질의명령의 결과를 받기위한 Hash 맵.
			HashMap result = mDAO.HashMapLoginProc(map);
			System.out.println("MemberService의 result"+result);			
			
			// 회원정보가 존재여부를 따져서 로그인 처리를 해준다.
			if(result==null || result.size()==0) {
				//회원아니다.
				System.out.println("MemberService의 loginProc()결과 :회원이 아니예요.");				
			}
			else {
				// 회원이다.
				// 로그인 처리를 해준다.
				System.out.println("MemberService의 loginProc()결과 :회원이예요.");
				session.setAttribute("UID", result.get("ID")); //맵의 키값 꺼내기)(sql문 AS)
				session.setAttribute("UNICK",result.get("NICK"));
				
				//참고
				// myBatis에서 결과를 Map으로 받는경우 키값이 필요.
				// 이 키값은 SELECT 된 컬럼명이 키값이 되어서 기억이 된다.
				// m_Id as ID 은 result.put("ID", "hongid")
				// 이 때 필드명이 대소문자 관계없이 항상 대문자로 변환되어서 기억된다.
			}			
		}
}


