package com.dream.mangle.domain;

import java.util.List;

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
public class ProductVO {
	
	private String prodCode;
	private String prodName;
	private String producer;
	private int stock;
	private int price;
	private float ratingAvg;
	private String categorized; //번호	
	private String accType; //케이스 종류

	private String citemtype; //번호
	private String citemcode; //일반.사진, 커스텀
	
	private CategoryVO category;
	private List<CartVO> cartlist;
	private TotalVO total;
	
	private String description;
}
