package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.BulkVO;

public interface BulkMapper {
	
	//답변없는 게시물 조회
	public List<BulkVO> selectBulkList(PagingDTO pagingDTO);
	
	//답변 게시물 조회
	public List<BulkVO> selectBulkReplyList();
	
	//페이징
	public long selectRowAmountTotal(PagingDTO pagingDTO);
	
	//게시물 등록
	public int insertBulk(BulkVO bulk);
	
	//특정 게시물 조회
	public BulkVO selectBulkDetail(long bno);
	
	//게시물 답글
	public int insertBulkReply(BulkVO bulk);
	
	//게시물 수정
	public int updateBulk(BulkVO bulk);
	
	//게시물 삭제
	public int deleteBulk(long bno);

}
