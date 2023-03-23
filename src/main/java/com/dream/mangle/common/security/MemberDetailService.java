package com.dream.mangle.common.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.dream.mangle.domain.MemberVO;
import com.dream.mangle.mapper.MemberMapper;

public class MemberDetailService implements UserDetailsService{
	
	private MemberMapper memberMapper;
	
	@Autowired
	public void setMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("Load User By UserName: " + username);
		MemberVO member = memberMapper.selectMember(username);
		
		return member == null ? null : new MemberUser(member);
	}

}
