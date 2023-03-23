package com.dream.mangle.domain;

import lombok.Setter;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class UploadFileVO {
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private String fileType;
	private String repoPath = "C:/myupload";
	private int eventNo;
	private long bulkno;
	private long reviewno;
	private long mtombno;

}
