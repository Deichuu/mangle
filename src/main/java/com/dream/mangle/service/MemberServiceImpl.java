package com.dream.mangle.service;

import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.dream.mangle.domain.AuthorityVO;
import com.dream.mangle.domain.MemberVO;
import com.dream.mangle.mapper.MemberMapper;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class MemberServiceImpl implements MemberService{
	
	private MemberMapper mapper;
	private BCryptPasswordEncoder encoder;
	
	@Override
	public MemberVO selectMember(String userEmail) {
		return mapper.selectMember(userEmail);
	}

	//회원가입
	@Override
	public boolean insertMember(MemberVO member) {
		System.out.println("member(Service)" + member);
		member.setUserPW(encoder.encode(member.getUserPW())); //가입 시 비밀번호는 암호화 처리
		int check = mapper.insertMember(member);
		System.out.println("check:" + check);
		return check == 1; //1값이 반환되면 가입 완료.
	}

	@Override
	public boolean insertMemberAuthority(AuthorityVO authority) {
		return mapper.insertMemberAuthority(authority) == 1;
	}
	
	//회원 조회: 회원 권한도 함께 조회됨 (스프링 시큐리티도 사용함), userEmail을 사용한 특정회원 조회
	@Override
	public MemberVO selectMemberService(String userEmail) {
		return mapper.selectMember(userEmail);
	}

	@Override
	public byte selectUseremail(String userEmail) {
		return mapper.selectUseremail(userEmail);
	}

	@Override
	public byte selectUsermobile(String userMobile) {
		return mapper.selectUsermobile(userMobile);
	}
	

	//회원정보수정(기존비번 일치여부)
	@Override
	public boolean checkPwService(MemberVO member) {
		MemberVO newMem = selectMember(member.getUserEmail());
		return encoder.matches(member.getUserPW(), newMem.getUserPW());
	}

	//회원정보 수정 (비밀번호)
	@Override
	public boolean updatePwService(MemberVO member) {
		member.setUserPW(encoder.encode(member.getUserPW()));
		return mapper.updatePw(member) == 1;
		
	}
	
	//회원정보 수정 (폰번호)
	@Override
	public boolean updateMobileService(MemberVO member) {
		return mapper.updateMobile(member) == 1;
		
	}
	
	//모든회원 목록 조회
	@Override
	public List<MemberVO> selectAllMember(){
		return mapper.selectAllMember();
	}
	

	//회원탈퇴
	@Override
	public boolean deleteMemberService(String userEmail) {
		SecurityContextHolder.clearContext(); //추가
		return mapper.deleteMember(userEmail)==1;
	}
	
}
