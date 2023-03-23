package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.domain.AddressVO;
import com.dream.mangle.domain.MemberVO;
import com.dream.mangle.domain.OrderAllLIstVO;
import com.dream.mangle.domain.OrderDetailVO;
import com.dream.mangle.domain.OrderSelectVO;
import com.dream.mangle.domain.OrderVO;

public interface OrderService {
	
	//주문정보 입력하기
	public void insertOrderService(OrderVO order);
	
	//주문상세 정보
	public void insertOrderinfoService(OrderDetailVO orderdetail);
	
	//카트 비우기
	public void deleteCartService(String userEmail);

	//주문내역 조회
	public List<OrderVO> selectServiceList();
	
	//특정 회원의 주문내역 조회 (특정 회원 orderId로 조회)
	public List<OrderAllLIstVO> selectMyListService(String userEmail);
	
	//주문요약=카트목록 끌어오기 (상품이름과 상품가격 join, userEmail로 가져오기)
	public List<OrderSelectVO> selectNamePriceService(String userEmail);
	
	//주문내역보기
	public OrderVO selectMyOrderService(String userId);
	
	//오더 디테일에서 가져오기
	public List<OrderSelectVO> selectOrderDetailProductList(String orderId);
	
	//포인트, 쿠폰 가져오기
	public MemberVO selectPointCoupon(String userEmail);	
	
	//주소갖고오기
	public List<AddressVO> selectUserAddress(String userEmail);
}
