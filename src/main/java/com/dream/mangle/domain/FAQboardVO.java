package com.dream.mangle.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FAQboardVO {
	
	private int faqNo; //글번호
	private String faqTitle; //제목
	private String faqContent; //내용
	private String faqWriter; //작성자
	private Date faqDate; //작성일
	private int faqViewCnt; //조회수
	private int faqDelFlag; //삭제 요청 추가.
	private String boardCate;
	
	
	

}
