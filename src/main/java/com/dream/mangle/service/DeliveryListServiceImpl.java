package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.domain.DeliveryVO;
import com.dream.mangle.domain.OrderVO;
import com.dream.mangle.mapper.DeliveryListMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class DeliveryListServiceImpl implements DeliveryListService{
	
	private DeliveryListMapper deliveryListMapper;
	
	@Override
	public List<OrderVO> selectAllDelivery() {
		return deliveryListMapper.selectAllDelivery();
	}

	@Override
	public int updateDelivery(DeliveryVO delivery) {
		return deliveryListMapper.updateDelivery(delivery);
	}

	@Override
	public int updateInvoice(DeliveryVO delivery) {
		return deliveryListMapper.updateInvoice(delivery);
	}

	
	
	
}
