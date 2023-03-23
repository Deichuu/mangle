package com.dream.mangle.common.download;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dream.mangle.domain.UploadDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class FileUploadController {
	
	private String uploadFileRepo = "C:/myupload";
	
	//호출
	@GetMapping(value="/fileUpload")
	public String callFileUploadPage() {
		return "board/fileUpload";
	}
	
	//날짜형식으로 폴더가 생길 문자열 생성
	private String getDatePathName() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
		
		Date date = new Date();
		
		String strDatePathName = simpleDateFormat.format(date);
		
		return strDatePathName;
	}
	
	//이미지파일 유무 확인
	private boolean CheckIsImageFile(File uploadFile) {
		try {
			String strContnetType = Files.probeContentType(uploadFile.toPath());
			
			return strContnetType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	//업로드 요청 파일 저장및 결과메시지 전송
	@PostMapping(value="/fileUpload" , produces = {"application/json; charset=utf-8"})
	@ResponseBody
	public ResponseEntity<List<UploadDTO>> fileUploadPost(MultipartFile[] uploadFiles){
		System.out.println("uploadfiles[0]: "+uploadFiles[0]);
		List<UploadDTO> listFileinfo = new ArrayList<UploadDTO>();
		
		String strDatePathName = getDatePathName();
		String strFileUploadPath = uploadFileRepo + "/" + strDatePathName;
		
		File fileUploadPath = new File(strFileUploadPath);
		
		if(!fileUploadPath.exists()) { fileUploadPath.mkdirs();	}
		
		for	(MultipartFile multipartFile : uploadFiles) {
			UploadDTO uploadInfo = new UploadDTO();
			uploadInfo.setUploadPath(strDatePathName);
			
			String strUploadFileName = multipartFile.getOriginalFilename();
			strUploadFileName = strUploadFileName.substring(strUploadFileName.lastIndexOf("\\") + 1);
			
			uploadInfo.setFileName(strUploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadInfo.setUuid(uuid.toString());
			strUploadFileName = uuid.toString() + "_" + strUploadFileName;
			
			File saveUploadFile = new File(fileUploadPath, strUploadFileName);
		try {
			
			if(CheckIsImageFile(saveUploadFile)) {
				uploadInfo.setFileType("I");				

				FileOutputStream fileOutputStream = new FileOutputStream(new File(fileUploadPath, "s_" + strUploadFileName));
					
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), fileOutputStream, 20, 20);
				
				fileOutputStream.flush();
				fileOutputStream.close();
			} else {
				uploadInfo.setFileType("F");
			}//else
			
				multipartFile.transferTo(saveUploadFile);			
			} catch (IOException e) {
				log.error(e.getMessage());
			}//catch
//			System.out.println("listFileInfo[1]: "+listFileinfo.get(0));
			listFileinfo.add(uploadInfo);
		} // for
		
		return new ResponseEntity<List<UploadDTO>>(listFileinfo, HttpStatus.OK);
	}//post fileUpload
	
	@GetMapping("/displayThumbnail")
	@ResponseBody
	public ResponseEntity<byte[]> sendThumbNailFile(String fileName){
		
		File file = new File(fileName);
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@PostMapping("/deleteUploadedFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String fileType){
		
		File delFile = null;
		
		try {
			delFile = new File(URLDecoder.decode(fileName, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		delFile.delete();
		
		if(fileType.equals("I")) {
			String imageFileName = delFile.getAbsolutePath().replace("/s_", "");
			delFile = new File(imageFileName);
			
		}
		
		return new ResponseEntity<String>("SuccessFileDelete", HttpStatus.OK);
	}
}

