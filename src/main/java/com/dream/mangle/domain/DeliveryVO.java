package com.dream.mangle.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class DeliveryVO {

	private String orderId;
	private String userEmail;
	private String dstatus;
	private String invoice;
	private int count;
	
	private List<OrderDetailVO> order;
}
