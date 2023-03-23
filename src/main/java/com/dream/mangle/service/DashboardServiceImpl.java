package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.domain.DeliCateVO;
import com.dream.mangle.domain.PerSumVO;
import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.mapper.DashboardMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class DashboardServiceImpl implements DashboardService {

	private DashboardMapper mapper;
	
	@Override
	public long selectMemberCnt() {
		return mapper.selectMemberCnt();
	}

	@Override
	public int selectNewMem() {
		return mapper.selectNewMem();
	}

	@Override
	public long selectTotalSales() {
		return mapper.selectTotalSales();
	}

	@Override
	public int selectNewMtoM() {
		return mapper.selectNewMtoM();
	}

	@Override
	public int selectNewOrder() {
		return mapper.selectNewOrder();
	}

	@Override
	public List<DeliCateVO> selectDstatus() {
		// TODO Auto-generated method stub
		return mapper.selectDstatus();
	}

	@Override
	public List<ProductVO> selectLowStock() {
		return mapper.selectLowStock();
	}

	@Override
	public List<DeliCateVO> selectPerCate() {
		return mapper.selectPerCate();
	}

	@Override
	public List<PerSumVO> selectSalePerDay() {
		
		List<PerSumVO> listSalePerDay = mapper.selectSalePerDay() ; 
		System.out.println("listSalePerDay: " + listSalePerDay);
		return listSalePerDay;
		//return mapper.selectSalePerDay();
	}

	@Override
	public List<PerSumVO> selectSalePerMonth() {
		return mapper.selectSalePerMonth();
	}

	@Override
	public List<PerSumVO> selectSalePerYear() {
		return mapper.selectSalePerYear();
	}

	@Override
	public List<ProductVO> selectBestProduct() {
		return mapper.selectBestProduct();
	}

}
