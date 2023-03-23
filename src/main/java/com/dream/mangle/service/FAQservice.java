package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.FAQboardVO;
import com.dream.mangle.domain.FaqCategoryVO;

public interface FAQservice {
	
	
	//게시판 말머리 선택 (말머리 호출)
	public List<FaqCategoryVO> selectCateService();
	
//	//게시물 조회 - 목록
//	public List<FAQboardVO> takeFaqList();
	
	//게시물 조회 - 페이징 고려
	public List<FAQboardVO> takeFaqList(PagingDTO pagingDTO);
	
	//게시물 총 개수 조회 서비스 - 페이징 시 필요
	public long getRowAmountTotal(PagingDTO pagingDTO);
	
	//게시물 조회: 게시물 조회 페이지 -> 게시물 수정 페이지 호출(by bno), 조회수 변화 없음
	//게시물 조회: 게시물 수정 후 -> 게시물 조회 페이지 호출(by bno), 조회수 증가 없음
	public FAQboardVO takeDetailModify(int faqNo);
	
	//게시물등록 - selectKey이용
	public int registerFaq(FAQboardVO faqBoard);
	
	//특정게시물 조회, 조회수증가고려 faqNo이용
	public FAQboardVO takeFaq(int faqNo);
	
	//특정게시물 수정
	public boolean modifyFaq(FAQboardVO faqBoard);
	
	//특정게시물 삭제
	public boolean deleteFaqService(int faqNo);

}
