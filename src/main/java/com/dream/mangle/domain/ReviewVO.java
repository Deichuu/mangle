package com.dream.mangle.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ReviewVO {
	private long rno;
	private String userEmail;
	private String prodCode;
	private String rcontent;
	private long rlike;
	private Timestamp rregDate;
	private int rating;
	
	private UploadFileVO rattfile;

}
