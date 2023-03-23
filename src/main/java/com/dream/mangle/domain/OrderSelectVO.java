package com.dream.mangle.domain;

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
public class OrderSelectVO {
	
	private String prodName;
	private int price;
	private int amount;
	private String prodCode;
	private String userEmail;
	private int total;
	private int point;
	
}
