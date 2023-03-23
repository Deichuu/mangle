package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.FAQboardVO;
import com.dream.mangle.domain.FaqCategoryVO;
import com.dream.mangle.mapper.FAQmapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class FAQServiceImpl implements FAQservice{

	private FAQmapper faqmapper; //faqmapper 주입
	
	//게시판 말머리 선택 (말머리 호출)
	@Override
	public List<FaqCategoryVO> selectCateService(){
		return faqmapper.selectCate();
	}
	
	//게시물 조회 - 목록
//	@Override
//	public List<FAQboardVO> takeFaqList() {
//		return faqmapper.selectFaqList();
//	}
	
	//게시물 조회 - 페이징고려
	@Override
	public List<FAQboardVO> takeFaqList(PagingDTO pagingDTO){
		return faqmapper.selectFaqList(pagingDTO);
	};
	
	//게시물 총 개수 조회 서비스 - 페이징 시 필요
	@Override
	public long getRowAmountTotal(PagingDTO pagingDTO) {
		return faqmapper.selectRowAmountTotalFaq(pagingDTO);
	}
	
	//게시물 조회: 게시물 조회 페이지 -> 게시물 수정 페이지 호출(by bno), 조회수 변화 없음
	//게시물 조회: 게시물 수정 후 -> 게시물 조회 페이지 호출(by bno), 조회수 증가 없음
	@Override
	public FAQboardVO takeDetailModify(int faqNo) {
		return faqmapper.selectFaq(faqNo);
	}

	
	//게시물등록 - selectKey이용
	@Override
	public int registerFaq(FAQboardVO faqBoard) {
		faqmapper.insertFaqSelectKey(faqBoard);
		return faqBoard.getFaqNo();
	}

	//특정 게시물 조회 (조회수 고려)
	@Override
	public FAQboardVO takeFaq(int faqNo) {
		faqmapper.updateViewCntFaq(faqNo); //조회수 먼저 증가 시킨 후 게시물조회 데이터 반환
		return faqmapper.selectFaq(faqNo);
	}

	
	//특정 게시물 수정
	@Override
	public boolean modifyFaq(FAQboardVO faqBoard) {
		return faqmapper.updateFaq(faqBoard)==1; //수정된 행수가 1이면 수정완료
	}

	//특정 게시물 삭제
	@Override
	public boolean deleteFaqService(int faqNo) {
		return faqmapper.deleteFaq(faqNo)==1; 
	}
	
}
