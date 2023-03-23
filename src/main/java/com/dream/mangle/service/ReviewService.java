package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.common.paging.ReviewPageCreateDTO;
import com.dream.mangle.common.paging.ReviewPagingDTO;
import com.dream.mangle.domain.ReviewVO;
import com.dream.mangle.domain.UploadFileVO;

public interface ReviewService {
	
	//리뷰 표시
	public ReviewPageCreateDTO SelectReview(ReviewPagingDTO reviewPagingDTO);
	
	//리뷰 등록
	public boolean RegistReview(ReviewVO reviewVO);
	
	//리뷰 수정
	public boolean ModifyReview(ReviewVO reviewVO);
	
	//리뷰 삭제
	public boolean removeReview(long rno,String prodCode);
	
	//리뷰에 저장된 파일 불러오기
	public UploadFileVO getImageFile(long reviewno);
	
	//좋아요 업
	public boolean likeUp(long rno);
	
	public void updateRatingAVG(String prodCode);

}
