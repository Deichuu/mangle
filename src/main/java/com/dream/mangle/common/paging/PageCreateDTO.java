package com.dream.mangle.common.paging;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PageCreateDTO {

	private PagingDTO pagingDTO;
	
	private int startPageNum;//시작 페이지
	private int endPageNum;//끝나는 페이지
	private int realPageNum;//실제 마지막 페이지
	
	private long totalRowCnt;//행의 총 갯수
	private int perPageCnt;//화면 아래에 표시할 페이지 개수
	
	private boolean prev; //이전 버튼
	private boolean next; //다음 버튼
	
	public PageCreateDTO(long totalRowCnt, PagingDTO pagingDTO) {
		this.pagingDTO = pagingDTO;
		this.totalRowCnt = totalRowCnt;
		this.perPageCnt = 10;
		
		this.endPageNum = (int) Math.ceil((pagingDTO.getPageNum() / (perPageCnt*1.0)))*perPageCnt;
		this.startPageNum = endPageNum - (perPageCnt -1) ;
		
		this.realPageNum = (int) Math.ceil(totalRowCnt*(1.0) / pagingDTO.getRowPerPage());
		
		if(endPageNum >realPageNum) {
			this.endPageNum = realPageNum;
		}
		
		this.prev = startPageNum >1;
		this.next = endPageNum <realPageNum;
		
		System.out.println("기본데이터-PagingDTO: " + pagingDTO.toString());
		System.out.println("끝 페이징번호: " + this.endPageNum);
		System.out.println("시작 페이징번호: " + this.startPageNum);
		System.out.println("이전버튼 표시 여부: " + this.prev);
		System.out.println("다음버튼 표시 여부: " + this.next);
		System.out.println("마지막 페이지 번호: " + this.realPageNum);
	}
	
}
