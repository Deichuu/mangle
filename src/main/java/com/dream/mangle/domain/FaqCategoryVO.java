package com.dream.mangle.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Data
public class FaqCategoryVO {
	
	private String cateName;
	private String cateCode;
	private String cateCodeRef;
	private int level;

}
