package com.dream.mangle.service;

import org.springframework.stereotype.Service;

import com.dream.mangle.domain.ProdDetailVO;
import com.dream.mangle.mapper.ProdDetailMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ProdDetailServiceImpl implements ProdDetailService {

	private ProdDetailMapper prodDetailMapper;

	@Override
	public ProdDetailVO selectProdScript(String prodCode) {
		System.out.println("서비스 전");
		ProdDetailVO result = prodDetailMapper.selectProdScript(prodCode);
		System.out.println("서비스 후: " + result);

		
		return result;
	}
	
	 
}
