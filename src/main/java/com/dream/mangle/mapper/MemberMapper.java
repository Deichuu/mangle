package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.domain.AuthorityVO;
import com.dream.mangle.domain.MemberVO;

public interface MemberMapper {
	public MemberVO selectMember(String userEmail);
	
	public Integer insertMember(MemberVO member);
	
	public Integer insertMemberAuthority(AuthorityVO authority);
	
	public byte selectUseremail(String userEmail);

	public byte selectUsermobile(String userMobile);
	
	//회원정보수정(기존비번 일치여부)
//	public MemberVO checkPw(String userEmail);
	
	//회원 정보 수정 (비밀번호)
	public int updatePw(MemberVO member);
	
	//회원 정보 수정 (폰번호)
	public int updateMobile(MemberVO member);
	
	//모든회원 목록 조회
	public List<MemberVO> selectAllMember();
	
	//회원탈퇴
	public int deleteMember(String userEmail);
	
	
	
}
