package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.AuthorityVO;
import com.dream.mangle.domain.MemberVO;

public interface MemberListMapper {
	
	
	public List<MemberVO> selectAllMemberList();

	public List<MemberVO> selectMemberSearch(PagingDTO paging);
	
	public int updateAuth(AuthorityVO auth);
}
