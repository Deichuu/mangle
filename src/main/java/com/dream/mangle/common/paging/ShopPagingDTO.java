package com.dream.mangle.common.paging;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ShopPagingDTO {
	
	private int pageNum;
	private int rowPerPage;
	private String scope;   //검색범위 : t=title / c=content / w=writer
	private String keyword; //검색어
	private String sort;
	private String producer;
	private String citemtype;
	private String categorized;
	
	
	public String[] getScopeArray() {		//twc값 배열로 주기
		 return scope == null ? new String[] {} : scope.split("");
	}
	
	
	public ShopPagingDTO() {
		this.pageNum = 1;
		this.rowPerPage = 12;
	}
	
	public ShopPagingDTO(int pageNum) {
		if(pageNum < 1) {
			this.pageNum = 1;
		}else {
			this.pageNum = pageNum;
		}
		
		this.rowPerPage = 12;
	}
	
	public ShopPagingDTO(int pageNum, int rowPerPage) {
		if(pageNum < 1) {
			this.pageNum = 1;
		}else {
			this.pageNum = pageNum;
		}
		
		if(rowPerPage < 1) {
			this.rowPerPage = 12;
		}else {
			this.rowPerPage = rowPerPage;
		}
	}
}
