package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.domain.AddressVO;
import com.dream.mangle.domain.MemberVO;
import com.dream.mangle.domain.OrderAllLIstVO;
import com.dream.mangle.domain.OrderDetailVO;
import com.dream.mangle.domain.OrderSelectVO;
import com.dream.mangle.domain.OrderVO;

public interface OrderMapper {
	//주문정보 입력하기
	public void insertOrder(OrderVO order);
	
	//주문상세 정보
	public void insertOrderinfo(OrderDetailVO orderdetail);
	
	//카트 비우기
	public void deleteCart(String userEmail);
	
	//주문내역 리스트 가져오기 (모든 회원)
	public List<OrderVO> selectOrderList();
	
	//주문요약 (상품이름과 상품가격 join, userEmail로 가져오기)
	public List<OrderSelectVO> selectNamePrice(String userEmail);
	
	//주문내역보기
	public OrderVO selectMyOrder(String userId);
	
	//특정 회원의 주문내역 조회 (특정 회원 userEamil로 조회)
	public List<OrderAllLIstVO> selectMyList(String userId);
	
	//딜리버리 테이블에 입력하기
	public void insertDelivery(OrderVO order);
	
	//주문 후 주문 디테일에서 리스트 가져오기
	public List<OrderSelectVO> selectOrderDetailProduct(String orderId);
	
	//주소 DB에 저장
	public int insertAddress(AddressVO address);
	
	//포인트, 쿠폰 가져오기
	public MemberVO selectUserInfo(String userEmail);
	
	//포인트 업데이트
	public int updatePoint(OrderVO order);
	
	//주소갖고오기
	public List<AddressVO> selectUserAddress(String userEmail);
	
	//회원별 주문 횟수
	public long orderCountMember(String userEmail);
	
	//주소 저장 체크
	public long AddressCount(String userEmail);
	
	//주소 저장 체크
	public int IsAddressHas(String reAddress);
	
	//쿠폰 사용
	public int useCoupon(OrderVO order);
}
