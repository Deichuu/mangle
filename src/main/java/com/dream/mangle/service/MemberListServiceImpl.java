package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.AuthorityVO;
import com.dream.mangle.domain.MemberVO;
import com.dream.mangle.mapper.MemberListMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberListServiceImpl implements MemberListService {

	private MemberListMapper memberListMapper;

	@Override
	public List<MemberVO> selectAllMemberList() {
		return memberListMapper.selectAllMemberList();
				
	}

	@Override
	public List<MemberVO> selectMemberSearch(PagingDTO paging) {
		return memberListMapper.selectMemberSearch(paging); 
	}

	@Override
	public int updateAuth(AuthorityVO auth) {
		return memberListMapper.updateAuth(auth);
	}


}

