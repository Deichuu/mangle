package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.domain.ProductVO;

public interface StockService {

	// 상품 추가
	public void addProd(ProductVO productVO);

	// 상품 목록 
	public List<ProductVO> getProdList();
	
	// 재고 수량 수정
	public int modifyStock(ProductVO productVO);
	
	// 상품 정보 삭제
	public int deleteProd(String prodCode);
	
}