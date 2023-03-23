package com.dream.mangle.common.upload;

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
public class UploadDTO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private String fileType;
	private String repoPath = "C:/myupload";
}
