package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.common.paging.ShopPagingDTO;
import com.dream.mangle.domain.ProductVO;

public interface ShopMapper {

	//전체 품목 리스트 
	public List<ProductVO> selectAllProd(ShopPagingDTO pagingDTO2);

	//페이징처리
	public long selectRowAmountTotal(ShopPagingDTO PagingDTO2);
	
	//카테고리 선택
	public List<ProductVO> selectCateType(ProductVO product);
	
	//제조사필터
	//public List<ProductVO> selectProducer(PagingDTO2 PagingDTO2);
	
	//낮은가격
	//public List<ProductVO> selectRow(PagingDTO2 PagingDTO2);
	
	//높은가격
	//public List<ProductVO> selectHigh(PagingDTO2 PagingDTO2);
	
	//인기순
	//public List<ProductVO> selectPop(PagingDTO2 PagingDTO2);
}
