package com.dream.mangle.common.security;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginLogoutContoroller {
	
	@GetMapping("/login")
	public String loginPageGet(String error, String logout, Model model) {
		if(error != null) {
			System.out.println("로그인 오류 시 error.hashCode(): " + error.hashCode());
			 model.addAttribute("error", "로그인 오류. 계정이나 암호를 확인하세요");
			 
			 return "member/signInUp";
		}else if (logout != null) {
			System.out.println("로그인 오류 시 error.hashCode(): " + logout.hashCode());
			model.addAttribute("logout", " 정상적으로 로그아웃 됨");
			return "member/signInUp";
		}
			 //정상적인 로그인 페이지 호출
			model.addAttribute("normal", "정상적인 로그인 페이지 호출 처리..");
			System.out.println("정상적인 로그인 페이지 호출");
			return "member/signInUp";
		}
		//로그아웃 페이지 호출: 로그아웃 JSP 페이지 이름 문자열 반환: WEB-INF/views/common/myLogout.jsp
		//로그아웃 페이지 호출은 GET 방식으로만 제한됨
			//@GetMapping("/myLogoutPage")
		@GetMapping("/logout") // 사용자 정의 로그아웃 JSP 페이지 호출 URL, 다른 URL을 사용해도 됨
		public String logoutPageGET() {
			System.out.println("로그아웃 페이지만 호출: 로그아웃은 처리 안됨......");
			return "member/logout"; 
		}
		
}
