package com.dream.mangle.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.mapper.StockMapper;

@Service
public class StockServiceImpl implements StockService{
	
	@Autowired
	private StockMapper stockMapper;
	
	
	@Override
	public void addProd(ProductVO productVO) {			
		// 상품 등록
		stockMapper.addProd(productVO);
		
	}
	
	
	@Override
	public List<ProductVO> getProdList(){
		
		List<ProductVO> productVO = stockMapper.getProdList();
		
		return productVO;
	}
	
	
	@Override
	public int modifyStock(ProductVO productVO) {
		
		return stockMapper.modifyStock(productVO);
	}
	
	
	@Override
	public int deleteProd(String prodCode) {

		return stockMapper.deleteProd(prodCode);
	}
	
}