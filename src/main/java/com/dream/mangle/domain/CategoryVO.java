package com.dream.mangle.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor

public class CategoryVO {
	private String categorized;
	private String accType;
	private String prodCode;
}
