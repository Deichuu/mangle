package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.domain.ProductVO;

public interface StockMapper {

	//상품 등록
	public void addProd(ProductVO productVO);

	//상품 목록
	public List<ProductVO> getProdList();	

	//재고 수량 수정
	public int modifyStock(ProductVO productVO);
	
	//상품 정보 삭제
	public int deleteProd(String prodCode);
	
}