package com.dream.mangle.common.download;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FileDownloadController {
	
	@GetMapping(value="/fileDownload", produces = "application/octet-stream")
	@ResponseBody
	public ResponseEntity<Resource> fileDownload(@RequestHeader("User-Agent") String userAgent, String fileName){
		
		Resource resource = new FileSystemResource(fileName);
		
		if(!resource.exists()) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceFileName = resource.getFilename();
		
		resourceFileName = resourceFileName.substring(resourceFileName.indexOf("_")+1);
		
		HttpHeaders httpHeaders = new HttpHeaders();
		
		String downloadFileName = null;
		
		try {		
			if(userAgent.contains("Trident") || userAgent.contains("MSIE") ||
			   userAgent.contains("Edge") || userAgent.contains("Edg")) {
				
				
					downloadFileName = URLEncoder.encode(resourceFileName, "UTF-8");
				
				
			} else {
				
				downloadFileName = new String(resourceFileName.getBytes("utf-8"), "ISO-8859-1");
				
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		httpHeaders.add("Content-Disposition", "attachment; filename=" + downloadFileName);
		
		return new ResponseEntity<Resource>(resource, httpHeaders, HttpStatus.OK);
	}

}
