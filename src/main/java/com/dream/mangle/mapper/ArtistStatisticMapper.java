package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.domain.OrderVO;
import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.domain.TotalVO;

public interface ArtistStatisticMapper {

	//개인 작가 통계
	public List<ProductVO> selectArtistProduct(String producer);
	
	//개인 작가 오늘 들어온 주문 확인
	public List<OrderVO> selectArtistToday(String producer);
	
	//개인 작가 오늘 들어온 주문 총 개수
	public TotalVO selectArtistTodayCount(String producer);
	
	//카테고리별 판매액
	public List<TotalVO> selectTotalCategory(String producer);
	
	//하루 주기 일주일 판매
	public List<TotalVO> selectPerDay(String producer);
	
	//한달 주기 판매
	public List<TotalVO> selectPerMonth(String producer);
	
	//1년 주기 판매
	public List<TotalVO> selectPerYear(String producer);
}
