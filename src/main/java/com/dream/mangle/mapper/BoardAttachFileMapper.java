package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.domain.UploadFileVO;

public interface BoardAttachFileMapper {
	
	//파일 저장
	public void insertUploadFile(UploadFileVO uploadFile);
	
	
	//게시판 파일가져오기
	public List<UploadFileVO> selectUploadFileList(long bno);
	
	
	//파일 하나 삭제
	public void deleteUploadFile(String uuid);
	
	
	//게시판에 있는 파일 다 삭제
	public void deleteBoardUploadFiles(long bno);
	
	
	//리뷰에 있는 파일 다 삭제
	public void deleteReviewUploadFiles(long rno);
	
	
	//하루전 파일 public List<BoardUploadFileVO> selectFilesBeforeOneDay();
}
