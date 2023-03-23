package com.dream.mangle.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderAllLIstVO {
	
	private String orderId;
	private String userEmail;
	private String receiver;
	private Date orderDate;
	private String prodName;
	private String prodCode;
	private int amount;
	private int price;
	private int total;
}
