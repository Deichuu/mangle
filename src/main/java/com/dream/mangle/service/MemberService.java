package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.domain.AuthorityVO;
import com.dream.mangle.domain.MemberVO;

public interface MemberService {
	
	public MemberVO selectMember(String userEmail);
	public boolean insertMember(MemberVO member);
	public boolean insertMemberAuthority(AuthorityVO authority);
	public byte selectUseremail(String userEmail);
	public byte selectUsermobile(String userMobile);
	//회원정보수정(기존비번 일치여부)
	public boolean checkPwService(MemberVO member);
	
	//회원정보 수정 (비밀번호)
	public boolean updatePwService(MemberVO member);
	
	//회원 정보 수정 (폰번호)
	public boolean updateMobileService(MemberVO member);
	
	//모든회원 목록 조회
	public List<MemberVO> selectAllMember();
	
	//회원탈퇴
	public boolean deleteMemberService(String userEmail);
	
	//회원 조회: 회원 권한도 함께 조회됨 (스프링 시큐리티도 사용함), userEmail을 사용한 특정회원 조회
	public MemberVO selectMemberService(String userEmail) ; 
	
}
