package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.domain.DeliveryVO;
import com.dream.mangle.domain.OrderVO;

public interface DeliveryListMapper {
	
	
	public List<OrderVO> selectAllDelivery();

	public int updateDelivery(DeliveryVO delivery);
	
	//송장번호 업데이트
	public int updateInvoice(DeliveryVO delivery);

}
