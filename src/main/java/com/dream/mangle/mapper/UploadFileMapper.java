package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.domain.UploadFileVO;

public interface UploadFileMapper {
	
	
	public int insertUploadFileEvent(UploadFileVO fileVO);
	
	public UploadFileVO selectUploadFileList(int eventNo);
	
	//bulk 파일 저장
	public void insertUploadFileBulk(UploadFileVO boardUploadFile);
	
	//review 파일 저장
	public void insertUploadReview(UploadFileVO boardUploadFile);
	
	//bulk 게시판 파일가져오기
	public List<UploadFileVO> selectBulkFileList(long bulkno);
	
	//review 게시판 파일가져오기
	public UploadFileVO selectReviewFile(long reviewno);
	
	//파일 하나 삭제
	public void deleteUploadFile(String uuid);
	
	//게시판에 있는 파일 다 삭제
	public void deleteBoardUploadFiles(long bno);
	
	//리뷰에 있는 파일 다 삭제
	public void deleteReviewUploadFiles(long rno);
	
	public int modifyReviewUploadFiles(UploadFileVO file);
}
