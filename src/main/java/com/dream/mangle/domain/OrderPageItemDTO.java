package com.dream.mangle.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class OrderPageItemDTO {

	// 뷰로부터 전달받을 값 
    private String prodCode;
    
    private int amount;
	
    
	// DB로부터 꺼내올 값
    private String prodName;
    
    private int price;
   
    
	// 만들어 낼 값
    private int totalPrice;
    
    private int point;
    
    private int totalPoint;
	
	
	public void initSaleTotal() {
		this.totalPrice = this.price*this.amount;
		this.point = (int)(Math.floor(this.price*0.01));
		this.totalPoint =this.point * this.amount;
	}

	
}