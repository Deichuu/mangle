package com.dream.mangle.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class EventVO {
	
	private int eventNo;
	private String eventTitle;
	private String eventContent;
	private Timestamp eventRegDate;
	private int eventview;
	private boolean eventendflag;
	
	private List<UploadFileVO> uploadFileList;
}
