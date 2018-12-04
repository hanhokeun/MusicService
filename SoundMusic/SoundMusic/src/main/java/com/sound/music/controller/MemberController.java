package com.sound.music.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.sound.music.service.MemberService;
import com.sound.music.vo.MemberVO;

@Controller
public class MemberController {

	// 스프링은 하나의 컨트롤러에 여러 개의 요청처리함수를 만들 수 있다.
	// 요청처리함수를 알려주기 위해서 @RequestMapping() 처리를 해주어야 한다.
	// 반환값 void, String, ModelAndView 중 택일 => 뷰 호출방식 결정
	@Autowired
	private MemberService mService;

	@RequestMapping("/member/LoginForm")
	public String loginForm() {		
		// 할일
		// 1. 파라미터를 받고
		// 2. 서비스 클래스에서 비즈니스 로직을 처리하도록 요청
		// 3. 그결과를 모델로 만들어서 뷰에게 전달
		return "member/LoginForm";
		
		/*참고
		스프링은 컨트롤러 함수는 비즈니스 로직부분을 처리하지 않도록 한다.
		서비스 개념의 클래스를 별도로 하여금 이 클래스를 이용하여
		비즈니스 로직을 처리하도록 분산 시켜 놓도록 한다.
		*/
	}
	
	@RequestMapping("/member/LoginProc")
	public ModelAndView loginProc(MemberVO vo,HttpSession session) {
		
		System.out.println("ModelAndView 리턴타입 요청함수");
		//할일
		// 1. 파라미터를 받고(req 방식과 VO 클래스를 매개변수로)
		// 2. 서비스 클래스에서 비즈니스 로직을 처리하도록 요청
		mService.loginProc(vo, session); // 필요한것을 준다.
		// 로그인이 끝나면 화면에 보여줄건 없고 대신에
		// 또 다른 작업을 하려고 한다.
		
		// 3. 그 결과를 모델
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView("../member/LoginForm.sun"); 
		// 4. 뷰지정(RedirectView용)
		// 파라미터가 필요하면 추가시킬 수 있다.
		// rv.addStaticAttribute(name, value)
		mv.setView(rv);		
		return mv;
	}
	
}
