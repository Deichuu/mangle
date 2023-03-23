package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.BulkVO;
import com.dream.mangle.domain.UploadFileVO;

public interface BulkService {

	//답변없는 게시물 조회
	public List<BulkVO> getBulkList(PagingDTO pagingDTO);
	
	public long getRowAmountTotal(PagingDTO pagingDTO);
	
	//답변 게시물 조회
	public List<BulkVO> getBulkReplyList(PagingDTO pagingDTO);
	
	//게시물 등록
	public long registerBulk(BulkVO bulk);
	
	//특정 게시물 조회
	public BulkVO getBulkDetail(long bno);
	
	//게시물 답글등록
	public long registerBulkReply(BulkVO bulk);
	
	//게시물 수정
	public boolean modifyBulk(BulkVO bulk);
	
	//게시물 삭제
	public boolean deleteBulk(long bno);
	
	//파일가져오기
	public List<UploadFileVO> getUploadFiles(long bulkno);
}
