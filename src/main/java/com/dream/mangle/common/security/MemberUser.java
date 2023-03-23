package com.dream.mangle.common.security;

import java.util.stream.Collectors;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.dream.mangle.domain.MemberVO;

public class MemberUser extends User{

	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	public MemberUser(MemberVO member) {
		super(member.getUserEmail(),
			  member.getUserPW(),
			  member.getAuthorityList().stream()
			  		.map(auth -> new SimpleGrantedAuthority(auth.getAuthority()))
			  		.collect(Collectors.toList())
			  );
		
		this.member = member;
	}

}
