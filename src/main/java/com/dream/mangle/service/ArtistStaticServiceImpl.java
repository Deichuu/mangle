package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.domain.OrderVO;
import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.domain.TotalVO;
import com.dream.mangle.mapper.ArtistStatisticMapper;

@Service
public class ArtistStaticServiceImpl implements ArtistStaticService{
	
	private ArtistStatisticMapper artistMapper;
	
	public ArtistStaticServiceImpl(ArtistStatisticMapper artistMapper) {
		this.artistMapper = artistMapper;
	}

	//작가 통계(제품코드, 제품이름, 제품 가격, 제품 평점, (핸드폰,그립톡,블루투스이어폰))
	@Override
	public List<ProductVO> getproductList(String producer) {
		System.out.println("producer: " + producer);
		List<ProductVO> productList = artistMapper.selectArtistProduct(producer); //
		System.out.println("productList: " + productList);
		return productList;
	}

	//오늘 들어온 주문 확인
	@Override
	public List<OrderVO> getTodaySales(String producer) {
		return artistMapper.selectArtistToday(producer);
	}

	//오늘 들어온 주문 개수
	@Override
	public TotalVO getTodayCount(String producer) {
		return artistMapper.selectArtistTodayCount(producer);
	}

	//카테고리별 판매액
	@Override
	public List<TotalVO> getTotalCategory(String producer) {
		return artistMapper.selectTotalCategory(producer);
	}

	//하루주기 일주일판매
	@Override
	public List<TotalVO> getPerDays(String producer) {
		
		List<TotalVO> perDay = artistMapper.selectPerDay(producer);
		
		System.out.println("perDay: " + perDay);
		
		return perDay;
	}

	//한달주기 판매
	@Override
	public List<TotalVO> getPerMonths(String producer) {
		
		System.out.println("producer: " + producer);
		
		List<TotalVO> perMonth = artistMapper.selectPerMonth(producer);
		
		System.out.println("perMonth: " + perMonth);
		
		return perMonth;
	}

	//일년 주기 판매
	@Override
	public List<TotalVO> getPerYears(String producer) {
		return artistMapper.selectPerYear(producer);
	}

}
