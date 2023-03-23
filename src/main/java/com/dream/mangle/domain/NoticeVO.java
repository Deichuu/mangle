package com.dream.mangle.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {

	private Long noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private String noticeWriter;
	private Timestamp noticeDate;
	private int noticeViewCnt;
	
}
