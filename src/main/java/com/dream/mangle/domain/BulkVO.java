package com.dream.mangle.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BulkVO {
	private long bno;
	private String btitle;
	private String bwriter;
	private String bcontent;
	private String bregDate;
	private long rbno;
	
	private List<UploadFileVO> uploadFileList;

}
