package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.domain.DeliveryVO;
import com.dream.mangle.domain.TotalVO;
import com.dream.mangle.mapper.DeliveryMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class DeliveryServiceImpl implements DeliveryService {

	private DeliveryMapper deliveryMapper;
	
	@Override
	public List<DeliveryVO> selectDeliveryList(String userEmail) {
		return deliveryMapper.selectDeliveryList(userEmail);
	}

	@Override
	public List<DeliveryVO> selectDeliveryDetail(String orderId) {
		return deliveryMapper.selectDeliveryDetail(orderId);
	}

	@Override
	public TotalVO selectTotal(String orderId) {
		return deliveryMapper.selectTotal(orderId);
	}
	
	@Override
	public int updateDstatus(DeliveryVO deliveryVO) {
		System.out.println("deliveryVO: "+deliveryVO);
		return deliveryMapper.updateDstatus(deliveryVO);
	}

}
