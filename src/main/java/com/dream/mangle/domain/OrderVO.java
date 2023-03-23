package com.dream.mangle.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class OrderVO {
	
	private String orderId;
	private String userEmail;
	private String receiver;
	private String reMobile;
	private String reAddress;
	private Date orderDate;
	private int amount;
	private int point;
	private int coupon;

	private AddressVO Address;
	private List<OrderDetailVO> orderDetailList;
	private List<DeliveryVO> deliveryList;
}