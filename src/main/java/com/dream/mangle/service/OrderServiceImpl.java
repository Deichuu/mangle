package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dream.mangle.domain.AddressVO;
import com.dream.mangle.domain.MemberVO;
import com.dream.mangle.domain.OrderAllLIstVO;
import com.dream.mangle.domain.OrderDetailVO;
import com.dream.mangle.domain.OrderSelectVO;
import com.dream.mangle.domain.OrderVO;
import com.dream.mangle.mapper.OrderMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	private OrderMapper ordermapper;
	
	//주문정보 입력하기
	@Override
	@Transactional
	public void insertOrderService(OrderVO order) {
		//회원의 주소저장 개수
		long count = ordermapper.AddressCount((order.getUserEmail()))+1;	
		
		//장바구니에서 제품들 가져오기
		List<OrderSelectVO> productList = ordermapper.selectNamePrice(order.getUserEmail());		
		
		//아이디+주문횟수 (주소테이블 키값)		
		if(ordermapper.IsAddressHas(order.getReAddress()) == 0) {
			order.setReAddress(order.getUserEmail()+ String.valueOf(count)); //주소키값 생성
			order.getAddress().setAddress_id(order.getReAddress());			//주소키값 저장
			
			ordermapper.insertAddress(order.getAddress());//주소 저장
		}
		
		//주문 테이블에 저장
		ordermapper.insertOrder(order);
		
		order.setPoint(selectPointCoupon(order.getUserEmail()).getUserPoint() - order.getPoint()); //전체 포인트에 현재 포인트를 뺌
		
		//주문 상세 정보 테이블에 주문번호저장
		OrderDetailVO orderDetail = new OrderDetailVO();		
		orderDetail.setOrderId(order.getOrderId());
		
		//제품별로 하나씩 제품코드와 수량을 저장
		for(OrderSelectVO orderSelect : productList) {
			orderDetail.setAmount(orderSelect.getAmount());
			orderDetail.setProdCode(orderSelect.getProdCode());
			ordermapper.insertOrderinfo(orderDetail);
		}
		
		//딜리버리 테이블에 저장
		ordermapper.insertDelivery(order);
		
		//쿠폰이 있다면
		if(order.getCoupon() == 5000) {
			String coupon = ordermapper.selectUserInfo(order.getUserEmail()).getUserCoupon();
			int couponCount = Integer.parseInt(coupon) - 1;
			order.setCoupon(couponCount);
			ordermapper.useCoupon(order);
		}
				
		//유저의 포인트 계산
		ordermapper.updatePoint(order);
		
		//모든 작업 끝난뒤 장바구니 제거
		ordermapper.deleteCart(order.getUserEmail());		
	}
	
	
	//주문상세 정보 등록
	@Override
	public void insertOrderinfoService(OrderDetailVO orderdetail) {
		ordermapper.insertOrderinfo(orderdetail);
		
	}

	
	//카트 비우기
	@Override
	public void deleteCartService(String userEmail) {
		ordermapper.deleteCart(userEmail);
	}
	
	
	//주문내역 조회 (모든 회원)
	@Override
	public List<OrderVO> selectServiceList() {
		
		return ordermapper.selectOrderList();
	}

	
	//특정 회원의 주문내역 조회 (특정 회원 userEamil로 조회)
	@Override
	public List<OrderAllLIstVO> selectMyListService(String userEmail){
		return ordermapper.selectMyList(userEmail);
	}


	//주문요약=카트목록 끌어오기 (상품이름과 상품가격 join, userEmail로 가져오기)
	public List<OrderSelectVO> selectNamePriceService(String userEmail){
		return ordermapper.selectNamePrice(userEmail);
	}

	@Override
	//주문내역보기
	public OrderVO selectMyOrderService(String userId){
		return ordermapper.selectMyOrder(userId);
	}
	
	//오더 디테일에서 가져오기
	@Override
	public List<OrderSelectVO> selectOrderDetailProductList(String orderId) {
		return ordermapper.selectOrderDetailProduct(orderId);
	}

	//포인트, 쿠폰 가져오기
	@Override
	public MemberVO selectPointCoupon(String userEmail) {
		return ordermapper.selectUserInfo(userEmail);
	}

	//유저 주소 불러오기
	@Override
	public List<AddressVO> selectUserAddress(String userEmail) {
		return ordermapper.selectUserAddress(userEmail);
	}
	
	public void insertAddress(AddressVO address ) {
		ordermapper.insertAddress(address);
	}
	
}
