package com.sound.music.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.sound.music.dao.MemberDAO;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.MemberVO;


@Service
public class MemberService {

		@Autowired
		private MemberDAO mDAO;
		
		//마이페이지 비밀번호변경처리
		public void changePw(MemberVO vo,HttpSession session) {
			
			String id = (String)session.getAttribute("UID");
			vo.setId(id);
			mDAO.changePw(vo);
			
		}
		
		//마이페이지 회원탈퇴
		public void memberDrop(MemberVO vo,HttpSession session) {
			
			String id = (String)session.getAttribute("UID");
			vo.setId(id);
			mDAO.memberDrop(vo);
		}
		
		//마이페이지 회원수정처리
		public void modifyPfProc(MemberVO vo,HttpSession session) {
			
			String id = (String)session.getAttribute("UID");
			vo.setId(id);
			mDAO.modifyPfProc(vo);
		}
		
		
		// 마이페이지
		public MemberVO proFile(MemberVO vo, HttpSession session) {
			
			String id = (String)session.getAttribute("UID");
			vo.setId(id);
			MemberVO result = mDAO.proFile(vo);
			return result;
		}
		
		// 회원비밀번호찾기
		public String getpwSearch(MemberVO vo) {
			/*System.out.println("회원 이이디 찾기 서비스");*/
			String result =  mDAO.pwSearch(vo);
			/*System.out.println("서비스의 result="+result);*/
			return result;
		}
		
		
		// 회원아이디 찾기
		public String getidSearch(MemberVO vo) {
			/*System.out.println("회원 이이디 찾기 서비스");*/
			String result =  mDAO.idSearch(vo);
			/*System.out.println("서비스의 result="+result);*/
			return result;
		}
		
		
		// 관리자 회원추방
		public void deleteMember(String id) {
			mDAO.DeleteMember(id);
			/*System.out.println("회원추방 서비스.java");*/
		}
		
		//관리자 회원목록조회
		public ArrayList getmemberList(PageUtil pInfo) {
			
			int start=(pInfo.getNowPage()-1)*pInfo.getListCount()+1;
			/*System.out.println("start="+start);*/
			
			//끝페이지 = 시작페이지 + 그 페이지에서 보여줄 게시물수-1
			int end = start + pInfo.getListCount()-1;
			/*System.out.println("end="+end);*/
			MemberVO vo = new MemberVO();		
			vo.setStart(start);
			vo.setEnd(end);
			/*System.out.println("vo.getStart()="+vo.getStart());
			System.out.println("vo.getEmd()="+vo.getEnd());*/
			
			ArrayList list= mDAO.getMemberList(vo);
			return list;			
		}
		
		//페이지 이동 정보를 만들어주는 함수
		public PageUtil getPageInfo(int nowPage) {
			//할일
			// 게시물 총 개수 구하기
			int totalCount=mDAO.getTotalCount();
			
			// 한 페이지당 3개의 게시물을 뿌리고, 5페이지씩 보여주자
			PageUtil pInfo=new PageUtil(nowPage, totalCount, 10, 5);
			/*System.out.println("pInfo.getListCount()="+pInfo.getListCount());
			System.out.println("pInfo.pInfo.getPageCount()="+pInfo.getPageCount());*/
			
			return pInfo;
		}
		
		// 회원가입처리
		public void signProc(MemberVO vo) {
			int result =mDAO.signProc(vo);
			if(result==1) {
				System.out.println("result값1 회원가입완료"+result);				
			}
			else {
				System.out.println("result값0 회원가입에러"+result );
				
			}			
		}
		
		//회원가입 아이디 중복체크
		public String idCheck(@RequestBody String userid) {
			String result=mDAO.getidcheck(userid);
			/*System.out.println("아이디중복체크 멤버서비스호출="+result);*/
			return result;
		}
		
	
		// 로그인처리 함수(함수명 상관없다.)
		public boolean loginProc(MemberVO vo,HttpSession session) { //MemberVo에서 데이터를 끄집어낸다.			
			
			//질의문을 실행할 때 필요한 정보는 Map으로 알려주기로 했으므로
			// Map 에 필요한 정보를 넣어서 알려줘야 한다.
			HashMap map = new HashMap();
			
			map.put("id",vo.getId());
			map.put("pw", vo.getPw());	
			
			HashMap result = mDAO.HashMapLoginProc(map);
			/*System.out.println("MemberService의 result"+result);*/			
			
			// 회원정보가 존재여부를 따져서 로그인 처리를 해준다.
			if(result==null || result.size()==0) {
				//회원아니다.
				/*System.out.println("MemberService의 loginProc()결과 :회원이 아니예요.");*/
				return false;			
			}
			else {
				// 회원이다.
				// 로그인 처리를 해준다.
				/*System.out.println("MemberService의 loginProc()결과 :회원이예요.");*/
				session.setAttribute("UID", result.get("ID")); //맵의 키값 꺼내기)(sql문 AS)
				return true;			
			}
		}
		
		
		//회원 로그아웃처리
		public void logOut(HttpSession session) {			
			//세션 정보를 초기화
			session.invalidate();
			/*System.out.println("로그아웃서비스");*/
		}		
}


