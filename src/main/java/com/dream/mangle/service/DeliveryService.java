package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.domain.DeliveryVO;
import com.dream.mangle.domain.TotalVO;

public interface DeliveryService {
	
	//배송리스트 조회
	public List<DeliveryVO> selectDeliveryList(String userEmail);

	//주문상세조회
	public List<DeliveryVO> selectDeliveryDetail(String orderId);

	//누계
	public TotalVO selectTotal(String orderId);
	
	//배송상태 업데이트
	public int updateDstatus(DeliveryVO deliveryVO);
}
