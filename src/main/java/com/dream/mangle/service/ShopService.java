package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.common.paging.ShopPagingDTO;
import com.dream.mangle.domain.ProductVO;

public interface ShopService {

	public List<ProductVO> selectAllProd(ShopPagingDTO pagingDTO2);
	
	public long selectRowAmountTotal(ShopPagingDTO pagingDTO2);
	
	public List<ProductVO> selectCateType(ProductVO product);
	
	//public List<ProductVO> selectProducer(PagingDTO2 PagingDTO2);
	
	//낮은가격
//	public List<ProductVO> selectRow(PagingDTO2 PagingDTO2);
	
	//높은가격
	//public List<ProductVO> selectHigh(PagingDTO2 PagingDTO2);
	
	//인기순
	//public List<ProductVO> selectPop(PagingDTO2 PagingDTO2);
}
