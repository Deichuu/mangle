package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.domain.DeliveryVO;
import com.dream.mangle.domain.OrderVO;

public interface DeliveryListService {
	
	//배송목록 조회
	public List<OrderVO> selectAllDelivery();
	
	//배송상태 변경
	public int updateDelivery(DeliveryVO delivery);
	
	//송장번호 업데이트
	public int updateInvoice(DeliveryVO delivery);



}
