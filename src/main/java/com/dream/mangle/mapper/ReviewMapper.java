package com.dream.mangle.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dream.mangle.common.paging.ReviewPagingDTO;
import com.dream.mangle.domain.ReviewVO;

public interface ReviewMapper {
	
	//리뷰 표시
	public List<ReviewVO> selectReview(ReviewPagingDTO reviewPagingDTO);
	
	//리뷰 총 개수
	public int selectTotalCnt(@Param("reviewPagingDTO") ReviewPagingDTO reviewPagingDTO);
	
	//리뷰 작성
	public Integer insertReview(ReviewVO reviewVO);
	
	//리뷰 수정
	public Integer updateReview(ReviewVO reviewVO);
	
	//좋아요1 상승
	public Integer likeUp(long rno);
	
	//리뷰 삭제
	public Integer deleteReview(long rno); 
	
	//제품 평점 업데이트	
	public void updateProductRatingAVG(String prodCode);
	
	//제품 점수 가져오기
	public float selectRatingAvg(String prodCode);
	
}
