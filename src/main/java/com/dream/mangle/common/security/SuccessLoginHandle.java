package com.dream.mangle.common.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class SuccessLoginHandle implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		System.out.println("로그인 성공 onAuthenticationSuccess");
		System.out.println("전달된 Authentication 객체 정보: " + authentication);
		
		List<String> roleNames = new ArrayList<>();//롤 목록을 저장
		 //권한이름 추출
		 authentication.getAuthorities() //인증객체에 저장되는 권한들(authorities)을 가져옴
		 .forEach( //각 권한(authority)의 권한이름(롤이름)을 리스트 객체에 저장
			 authority -> {
				 	roleNames.add(authority.getAuthority());
			 }
		 );//End of forEach
		 
		 System.out.println("ROLE NAMES: " + roleNames); //권한(롤)이름 리스트를 콘솔 표시
		 
		
	}

}
