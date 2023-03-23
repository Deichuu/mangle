package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.domain.DeliCateVO;
import com.dream.mangle.domain.PerSumVO;
import com.dream.mangle.domain.ProductVO;

public interface DashboardMapper {

	//회원 수
	public long selectMemberCnt();
	
	//이번 주에 가입한 회원
	public int selectNewMem();
	
	//총 매출
	public long selectTotalSales();
	
	//답글이 달리지 않은 문의 답변 개수
	public int selectNewMtoM();
	
	//오늘 들어온 주문
	public int selectNewOrder();
	
	//배송 진행 상황
	public List<DeliCateVO> selectDstatus();
	
	//재고 3개이하
	public List<ProductVO> selectLowStock();
	
	//카테고리 별 판매액(그래프)
	public List<DeliCateVO> selectPerCate();
	
	//일주일간 일 매출
	public List<PerSumVO> selectSalePerDay();
	
	//월 매출
	public List<PerSumVO> selectSalePerMonth();
	
	//년도별 매출
	public List<PerSumVO> selectSalePerYear();
	
	//판매량 높은 순위로 5개
	public List<ProductVO> selectBestProduct();
}
