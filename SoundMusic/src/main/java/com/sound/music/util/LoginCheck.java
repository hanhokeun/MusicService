package com.sound.music.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 이 클래스는 컨트롤러가 실행되기 전에 인터셉터를 해서 먼저 실행할 클래스
// 인터셉터 클래스

//	인터셉터 클래스가 되기 위한 조건
//	반드시 HandlerInterceptorAdapter 를 상속받아야한다.
//	preHandle 함수를 오버라이드 해야 한다.

public class LoginCheck extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// True 를 리턴하면 컨트롤러가 실행되고
		// False를 리턴하면 컨트롤러가 실행하지 않는다.
		System.out.println("Logincheck실행되고 있니?"+handler);
		
		HttpSession session =request.getSession(); // 세션이 있는지 없는지 확인을 위해
		String id =(String)session.getAttribute("UID");
		if(id == null || id.length()==0) {
			// 로그인이 아니된 경우
			
			// false 를 반환하면 컨트롤러가 실행되지 않고 무응답상태로 된다는 문제발생
			
			//로그인 폼을 보여줘
			//푸시용
			try {
			response.sendRedirect("../member/LoginForm.sm");
			}
			catch(Exception e) {
				
			}
			return false;
		}
		else {
			// 로그인이 된경우
			return true;
		}		
	}

}

