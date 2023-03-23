package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.FAQboardVO;
import com.dream.mangle.domain.FaqCategoryVO;

public interface FAQmapper {
	
	//게시판 말머리 선택 (말머리 호출)
	public List<FaqCategoryVO> selectCate();
	
	//게시물 조회 - 목록 (페이징 고려 완)
	public List<FAQboardVO> selectFaqList(PagingDTO pagingDTO);
	
	//게시물 총 개수 조회(페이징)
	public long selectRowAmountTotalFaq(PagingDTO pagingDTO);
	
	//게시물등록 - selectKey이용
	public int insertFaqSelectKey(FAQboardVO faqBoard);
	
	//특정 게시물 조회
	public FAQboardVO selectFaq(int faqNo);
		
	
	//특정 게시물 수정
	public int updateFaq(FAQboardVO faqVO);
	
	//특정 게시물 삭제 (추가) - 추가하는게 그래도 나을 것 같아서 추가했어욤,,, 뿌잉
	public int deleteFaq(int faqNo);
	
	//특정 게시물 조회수 증가
	public void updateViewCntFaq(int faqNo);
	
	
	
	
}
