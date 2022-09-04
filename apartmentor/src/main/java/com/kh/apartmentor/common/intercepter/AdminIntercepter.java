package com.kh.apartmentor.common.intercepter;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.apartmentor.member.model.vo.Member;

public class AdminIntercepter extends HandlerInterceptorAdapter {
	
	/*
	 * HandlerIntercepter
	 * 
	 * -- Controller가 실행되기 전 / 실행 된 후 낚아채서 실행할 내용을 작성가능
	 * -- 로그인 유/무 판단, 회원의 권한체크
	 * 
	 * preHandle(전처리) : DispatcherServlet이 컨트롤러를 호출하기 전에 낚아채는 영역
	 * postHandle(후처리) : 컨트롤러에서 요청 처리 후 DispatcherServlet으로 View정보가 리턴되는 순간 낚아채는 영역
	 */
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
		// true 리턴 시 => 기존 요청 흐름대로 해당 Controller 정상 실행
		// false 리턴 시  => Controller 실행 안됨
		
		HttpSession session = request.getSession();
		Member loginUser = (Member)session.getAttribute("loginUser");
		// 현재 요청을 보낸 사람이 로그인 되어있을 경우 => Controller 실행
		if(loginUser.getUserId().equals("admin") && session.getAttribute("loginUser") != null) {
			return true;
		} else { // 로그인 되어있지 않은 경우 => Controller 실행 X
			session.setAttribute("alertMsg1", "관리자로 로그인 후 이용가능한 서비스입니다.");
			response.sendRedirect(request.getContextPath());
			return false;
		}
	}
	

}
