package com.dream.mangle.domain;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class TotalVO {
	private String category;
	private long totalPrice;
	private long count;
	
	private String orderDate;
}
