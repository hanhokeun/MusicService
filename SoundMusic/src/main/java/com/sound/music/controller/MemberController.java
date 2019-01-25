package com.sound.music.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.sound.music.dao.MemberDAO;
import com.sound.music.service.MemberService;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired	
	private MemberService mService;
	
	@Autowired
	private MemberDAO dao;
	
	//	
	//마이페이지 비밀번호 변경처리
	@RequestMapping(value="/ChangePwProc",method= {RequestMethod.POST,RequestMethod.GET})
	public void ChangePw(MemberVO vo,HttpSession session,HttpServletResponse resp) throws IOException {
		
		String pw = vo.getPw();
		String cpw = vo.getCpw();	
		
		vo.setPw(pw);
		vo.setCpw(cpw);		
		
		int result = mService.changePw(vo, session);
		System.out.println("비번변경 컨트롤러="+result);			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		if(result==1) {	
			mService.logOut(session);			
			out.println("<script>");
			out.println("alert('비밀번호가 성공적으로 변경되었습니다'); location.href='../member/LoginForm.sm';");
			out.println("</script>");
			out.close();
		}
		else {
		
			out.println("<script>");
			out.println("alert('현재 비밀번호가 맞지 않습니다.'); location.href='../member/ChangePw.sm';");
			out.println("</script>");
			out.close();
		}		
	}
	
	//마이페이지 비밀번호 변경폼요청
	@RequestMapping("/ChangePw")
	public void ChangePw() {
		
	}	
	
	
	//마이페이지 회원탈퇴 요청
	@RequestMapping("/MemberDrop")
	public ModelAndView MemberDrop(MemberVO vo,HttpSession session) {	
		
		mService.memberDrop(vo, session);		
		mService.logOut(session);
		
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView("./../main.jsp");	
		mv.setView(rv);
		return mv;
	}
	
	
	//마이페이지 수정처리 요청	
	@RequestMapping(value="/ProfileProc",method=RequestMethod.POST)
	public ModelAndView modifyPfProc(MemberVO vo,HttpSession session) {				
		
		String gender = vo.getGender();
		String email = vo.getEmail();	
		
		mService.modifyPfProc(vo, session);
		
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView("../member/Profile.sm");	
		mv.setView(rv);
		return mv;
		
	}
	
	
	//마이페이지 수정폼 요청
	@RequestMapping("/ProfileModify")
	public ModelAndView profileModify(ModelAndView mv,MemberVO vo,HttpSession session) {		
		
		MemberVO result =mService.proFile(vo,session);
		
		mv.addObject("MEM",result);
		
		mv.setViewName("member/ProfileModify");
		
		return mv;
		
	}
	
	//마이페이지 폼요청
	@RequestMapping("/Profile")
	public ModelAndView ProFile(ModelAndView mv,MemberVO vo,HttpSession session) {	
		
		MemberVO result =mService.proFile(vo,session);
		
		mv.addObject("MEM",result);
		
		mv.setViewName("member/Profile");
		
		return mv;
	}
	
	
	//비밀번호 찾기 처리
	@ResponseBody
	@RequestMapping(value="/PwSearchProc", method=RequestMethod.GET)	
	public String PwSearchProc( @RequestParam(value="id") String id,
									@RequestParam(value="name") String name,
									@RequestParam(value="gender") String gender,
									@RequestParam(value="email") String email,MemberVO vo) throws Exception{			
			
		vo.setId(id);
		vo.setName(name);
		vo.setGender(gender);
		vo.setEmail(email);			
		
		String result = mService.getpwSearch(vo);		
		return result;
	}
	
	//비밀번호 찾기폼요청
	@RequestMapping("/PwSearch")
	public void PwSearch() {
			
	}
	
	//아이디 찾기 처리
	@ResponseBody
	@RequestMapping(value="/IdSearchProc", method=RequestMethod.GET)	
	public String IdSearchProc( @RequestParam(value="name") String name,
								@RequestParam(value="gender") String gender,
								@RequestParam(value="email") String email,MemberVO vo) throws Exception{
		
		
		vo.setName(name);
		vo.setGender(gender);
		vo.setEmail(email);	
		
		String result = mService.getidSearch(vo);		
		return result;
	}
	
	//아이디 찾기폼요청
	@RequestMapping("/IdSearch")
	public void idSearch() {
		
	}	
	
	//회원관리페이지 회원추방
	@RequestMapping("/MemberDelete")
	public ModelAndView MemberDelete(@RequestParam(value="id") String id){		
		
		System.out.println("추방컨트롤러="+id);
		mService.deleteMember(id);
		
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView("../member/MemberList.sm");	
		mv.setView(rv);
		return mv;		
		
	}
	
	//회원관리페이지 검색기능
		@RequestMapping("/MemberSearch")
		public ModelAndView MemberSearch(ModelAndView mv, HttpServletRequest req) {
		
			String target = req.getParameter("target");
			String word = req.getParameter("word");
			
			String strPage = req.getParameter("nowPage");
			int nowPage = 1;
			if(strPage==null  || strPage.length()==0) {
				nowPage = 1;
			}
			else {
				nowPage = Integer.parseInt(strPage);
			}
			
			MemberVO vo = new MemberVO();
			vo.setTarget(target);
			vo.setWord(word);
			PageUtil pInfo = mService.getSearchPage(vo, nowPage);
			
			//검색어를 이용하여 실제 데이터를 db에서 검색하고
			ArrayList list = mService.memberSearch(vo, pInfo);
			mv.addObject("target",target);
			mv.addObject("word",word);
			mv.addObject("PINFO",pInfo);
			mv.addObject("LIST",list);
			
			mv.setViewName("member/MemberSearch");
			return mv;
			
			
		}
	
	//회원관리자페이지 이동
	@RequestMapping("/MemberList")
	public void MemberList(@RequestParam(value="nowPage", defaultValue="1") int nowPage,HttpServletRequest req) {		
		// 페이지 이동 기능
		PageUtil pInfo = mService.getPageInfo(nowPage);
		
		//회원목록 꺼내오기		
		ArrayList list = mService.getmemberList(pInfo);
		
		//모델
		req.setAttribute("PINFO", pInfo);
		req.setAttribute("LIST", list);
		// 뷰
		
	}	
	
	// 회원가입 처리 요청
	@RequestMapping(value="/SignProc",method=RequestMethod.POST)
	public ModelAndView signProc(MemberVO vo) {
		System.out.println("회원가입요청 들어온다.");
		String id = vo.getId();
		String pw = vo.getPw();
		String name = vo.getName();
		String gender = vo.getGender();
		String email = vo.getEmail();		
		
		mService.signProc(vo);
		
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView("../member/LoginForm.sm");	
		mv.setView(rv);
		return mv;
	}
	
	// 회원가입 ID중복체크 요청
	@ResponseBody
	@RequestMapping(value="/IdCheck", method= RequestMethod.POST)
	public String idcheck(@RequestBody String userid) throws Exception {
				
		String result =mService.idCheck(userid);
		return result;			
		
	}
	
	// 회원가입 폼 요청
	@RequestMapping("/SignUp")
	public void signUp() {
		
	}
	

	// 로그아웃 요청
	@RequestMapping("/LogOut")
	public ModelAndView LogOut(HttpSession session) {
			
		mService.logOut(session);		
		
		ModelAndView mv = new ModelAndView();
		RedirectView view = new RedirectView("../main.jsp");
		mv.setView(view);
		return mv;
	}
		
		
	
	// 로그인 처리 요청
	@RequestMapping("/LoginProc")
	public ModelAndView loginProc(MemberVO vo,HttpSession session) {				
		
		boolean result = mService.loginProc(vo, session); // 필요한것을 준다.		
		
		ModelAndView mv = new ModelAndView();
		RedirectView rv = null;
		
		if(result==true) {
			rv = new RedirectView("../main.jsp");
		}
		else {
			rv = new RedirectView("../member/LoginForm.sm");
		}
		mv.setView(rv);
		return mv;
	}
	
	// 로그인 폼 요청
	@RequestMapping("/LoginForm")
	public String loginForm() {		
		return "member/LoginForm";	
	}	
		
}
