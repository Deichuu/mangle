package com.dream.mangle.common.paging;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PagingDTO {

	private int pageNum;
	private int rowPerPage;
	private String scope;
	private String keyword;
	private String boardCate; //boardCate 추가했음!
	
	public String[] getScopeArray() {
		 return scope == null ? new String[] {} : scope.split("");
	}
	
	public PagingDTO() {
		this.pageNum = 1;
		this.rowPerPage = 10;
	}
	
	
	public String addPagingParamsToURI() {
		
		UriComponentsBuilder uriComponentsBuilder = 
				UriComponentsBuilder.fromPath("")
									.queryParam("pageNum", this.pageNum)
									.queryParam("rowPerPage", this.rowPerPage)
									.queryParam("scope", this.scope)
									.queryParam("keyword", this.keyword);									
		
		String uriString = uriComponentsBuilder.toUriString();
		System.out.println("생성된 파라미터 추가 URI 문자열: " + uriString);
		
		return uriString;
		
		//return UriComponentsBuilder.toUriString();
	}
	
	public PagingDTO(int pageNum) {
		if(pageNum < 1) {
			this.pageNum = 1;
		}else {
			this.pageNum = pageNum;
		}
		
		this.rowPerPage = 10;
	}
	
	public PagingDTO(int pageNum, int rowPerPage) {
		if(pageNum < 1) {
			this.pageNum = 1;
		}else {
			this.pageNum = pageNum;
		}
		
		if(rowPerPage < 1) {
			this.rowPerPage = 10;
		}else {
			this.rowPerPage = rowPerPage;
		}
	}
}
