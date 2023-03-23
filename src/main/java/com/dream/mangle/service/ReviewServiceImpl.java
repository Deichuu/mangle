package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dream.mangle.common.paging.ReviewPageCreateDTO;
import com.dream.mangle.common.paging.ReviewPagingDTO;
import com.dream.mangle.domain.ReviewVO;
import com.dream.mangle.domain.UploadFileVO;
import com.dream.mangle.mapper.ReviewMapper;
import com.dream.mangle.mapper.UploadFileMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReviewServiceImpl implements ReviewService {
	
	
	private ReviewMapper reviewMapper;	
	private UploadFileMapper uploadFileMapper;
		
	public ReviewServiceImpl(ReviewMapper reviewMapper, UploadFileMapper uploadFileMapper) {
		this.reviewMapper = reviewMapper;
		this.uploadFileMapper = uploadFileMapper;
	}

	//리뷰 표시
	@Override
	public ReviewPageCreateDTO SelectReview(ReviewPagingDTO reviewPagingDTO) {
		
		System.out.println("컨트롤러부터 전달된 myReplyPagingDTO: " + reviewPagingDTO);
		
		long reviewTotalCnt = reviewMapper.selectTotalCnt(reviewPagingDTO);
		
		int pageNum = reviewPagingDTO.getPageNum();
		
		ReviewPageCreateDTO reviewPageCreate = null;
		
		if(reviewTotalCnt == 0) {
			reviewPagingDTO.setPageNum(1);
			System.out.println("댓글-서비스- 댓글이 없는 경우, pageNum은 1: 수정된 reviewPagingDTO: " + reviewPagingDTO);
			
			reviewPageCreate = 
					new ReviewPageCreateDTO(
							0,
							reviewPagingDTO,
							reviewMapper.selectReview(reviewPagingDTO),
							0f);				
		} else {
			if(pageNum == -10) {
			   pageNum = (int) Math.ceil(reviewTotalCnt/(reviewPagingDTO.getRowPerPage()*1.0));
			   
			   reviewPagingDTO.setPageNum(pageNum);
			}
			
		}
	
		List<ReviewVO> reviews = reviewMapper.selectReview(reviewPagingDTO);
		
		for (ReviewVO review : reviews) {
			review.setRattfile(uploadFileMapper.selectReviewFile(review.getRno()));
		}
			
		reviewPageCreate = 
				new ReviewPageCreateDTO(
						reviewMapper.selectTotalCnt(reviewPagingDTO),
						reviewPagingDTO,
						reviews,
						reviewMapper.selectRatingAvg(reviewPagingDTO.getProdCode()));
		
		System.out.println("컨트롤러로 전달할 myReplyPagingCreator: " + reviewPageCreate);
		
		return reviewPageCreate;		
	}

	//리뷰 등록
	@Override
	@Transactional
	public boolean RegistReview(ReviewVO reviewVO) {
		
		reviewMapper.insertReview(reviewVO);
		reviewMapper.updateProductRatingAVG(reviewVO.getProdCode());
		
		if(reviewVO.getRattfile().getUuid() == null) {
			return true;
		}
		
		reviewVO.getRattfile().setReviewno(reviewVO.getRno());
		uploadFileMapper.insertUploadReview(reviewVO.getRattfile());
		
		return true;
	}
	

	//리뷰 수정
	@Override
	@Transactional
	public boolean ModifyReview(ReviewVO reviewVO) {
		reviewMapper.updateReview(reviewVO );
		reviewMapper.updateProductRatingAVG(reviewVO.getProdCode());
		
		if(reviewVO.getRattfile().getUuid() == null) {
			return true;
		}
		
		reviewVO.getRattfile().setReviewno(reviewVO.getRno());
		
		if(uploadFileMapper.selectReviewFile(reviewVO.getRno()) == null) {
			uploadFileMapper.insertUploadReview(reviewVO.getRattfile());
		} else {
		uploadFileMapper.modifyReviewUploadFiles(reviewVO.getRattfile());
		}		
		return true;
	}

	//리뷰 삭제
	@Override
	public boolean removeReview(long rno,String prodCode) {
		reviewMapper.deleteReview(rno);
		updateRatingAVG(prodCode);
		return true;
	}
	
	//업로드파일 받아오기	
	  @Override
	  public UploadFileVO getImageFile(long reviewno) {		  
		  return uploadFileMapper.selectReviewFile(reviewno);
	  }
	 
	//좋아요 업
	  @Override
	  public boolean likeUp(long rno) {
		  		  
		  return reviewMapper.likeUp(rno)==1;
	  }
	  
	  
	  @Override
	  public void updateRatingAVG(String prodCode) {
		  reviewMapper.updateProductRatingAVG(prodCode);
	  }

}
