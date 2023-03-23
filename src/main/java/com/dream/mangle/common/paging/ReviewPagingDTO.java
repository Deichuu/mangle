package com.dream.mangle.common.paging;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewPagingDTO {

	private String prodCode;
	private int pageNum;
	private int rowPerPage;
			
	public ReviewPagingDTO(String prodCode, Integer pageNum) {
		this.prodCode = prodCode;
		
		if(pageNum == null) {
			this.pageNum = 1;
		} else {
			this.pageNum = pageNum;
		}
		
		this.rowPerPage = 5;
	}
}
