package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.domain.ProductVO;

public interface ProductService {
	//특정상품조회
	public ProductVO selectProd(String prodCode);
	
	public List<ProductVO> selectRatingAvg();
}
