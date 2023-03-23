package com.dream.mangle.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class OrderListVO {
	
	private String orderId;
	private String userEmail;
	private String receiver;
	private String reMobile;
	private String reAddress;
	private Date orderDate;
	
	private String prodCode;
	
	private int amount;
	
	
	//join문에 대한 VO
	

}
