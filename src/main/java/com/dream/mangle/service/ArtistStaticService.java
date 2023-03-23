package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.domain.OrderVO;
import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.domain.TotalVO;

public interface ArtistStaticService {
	
	//작가 통계
	public List<ProductVO> getproductList(String producer);
	
	//오늘 들어온 주문 확인
	public List<OrderVO> getTodaySales(String producer);
	
	//오늘 들어온 주문 개수와 총 금액
	public TotalVO getTodayCount(String producer);
	
	//카테고리별 판매액
	public List<TotalVO> getTotalCategory(String producer);
	
	//하루주기 일주일판매
	public List<TotalVO> getPerDays(String producer);
	
	//한달주기 판매
	public List<TotalVO> getPerMonths(String producer);
	
	//일년 주기 판매
	public List<TotalVO> getPerYears(String producer);

}
