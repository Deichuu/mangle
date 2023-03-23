package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.mapper.ProductMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProductServiceImpl implements ProductService{

	private ProductMapper mapper;
	@Override
	public ProductVO selectProd(String prodCode) {
		return mapper.selectdetailProd(prodCode);
	}
	
	@Override
	public List<ProductVO> selectRatingAvg() {
		return mapper.selectRatingAvg();
	}

}
