package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.common.paging.ShopPagingDTO;
import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.mapper.ShopMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ShopServiceImpl implements ShopService {
	
	private ShopMapper shopMapper; 
	
	@Override
	public List<ProductVO> selectAllProd(ShopPagingDTO pagingDTO2) {
		return shopMapper.selectAllProd(pagingDTO2);
	}

	@Override
	public long selectRowAmountTotal(ShopPagingDTO pagingDTO2) {
		System.out.println(pagingDTO2);
		long totalcount = shopMapper.selectRowAmountTotal(pagingDTO2);
		System.out.println("totalcount: " + totalcount);
		return totalcount;
	}

	@Override
	public List<ProductVO> selectCateType(ProductVO product) {
		List<ProductVO> result = shopMapper.selectCateType(product);
		System.out.println("List;==========================" + result);
		return result;
	}

//	@Override
//	public List<ProductVO> selectProducer(PagingDTO2 PagingDTO2) {
//		return shopMapper.selectProducer(PagingDTO2);
//	}

//	@Override
//	public List<ProductVO> selectRow(PagingDTO2 PagingDTO2) {
//		return shopMapper.selectRow(PagingDTO2);
//	}
//
//	@Override
//	public List<ProductVO> selectHigh(PagingDTO2 PagingDTO2) {
//		return shopMapper.selectHigh(PagingDTO2);
//	}
//
//	@Override
//	public List<ProductVO> selectPop(PagingDTO2 PagingDTO2) {
//		return shopMapper.selectPop(PagingDTO2);
//	}

}
