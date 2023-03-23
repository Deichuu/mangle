package com.dream.mangle.common.cart;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class CartDTO {

	private int cartId;
	
	private String userEmail;
	
	private String prodCode;
	
	private int amount;
	
	
	//product
	private String prodName;
	
	private int price;
	
	
	//추가
	private int totalPrice;
		
	public void totalPrice() {
		this.totalPrice = this.price * this.amount;
	}
	
}