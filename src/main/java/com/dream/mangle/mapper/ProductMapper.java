package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.ProductVO;

public interface ProductMapper {
	
	//상품 목록 조회
	public List<ProductVO> selectProdList(String categorized) ;

	//상품 총 개수 조회(페이징)
	public int selectTotal(PagingDTO prodPagingDTO);
	
	//특정 상품 조회
	public ProductVO selectProd(String prodName);
	
	//상품 등록
	public Integer insertProd(ProductVO productVO);
	
	//특정 상품 상세페이지 이동
	public ProductVO selectdetailProd(String prodCode);
	
	//상품 수정
	public int updeteprod(ProductVO productVO);
	
	//상품 삭제
	public int deleteProd(String prodCode);
	
	//상품 조회수 증가
//	public void updateRating(int ratingAvg);
	
	public List<ProductVO> selectRatingAvg();
	
	
	

}
