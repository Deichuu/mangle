package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.BulkVO;
import com.dream.mangle.domain.UploadFileVO;
import com.dream.mangle.mapper.BulkMapper;
import com.dream.mangle.mapper.UploadFileMapper;

@Service
public class BulkServiceImpl implements BulkService{
	
	private BulkMapper bulkMapper;
	
	private UploadFileMapper UploadFileMapper;
	
	public BulkServiceImpl(BulkMapper bulkMapper, UploadFileMapper uploadFileMapper) {
		this.bulkMapper = bulkMapper;
		this.UploadFileMapper = uploadFileMapper;
	}

	//답변없는 게시물 목록 조회
	@Override
	public List<BulkVO> getBulkList(PagingDTO pagingDTO) {
		System.out.println("pagingDTO: " + pagingDTO);
		return bulkMapper.selectBulkList(pagingDTO);
	}

	//페이징
	@Override
	public long getRowAmountTotal(PagingDTO pagingDTO) {
		return bulkMapper.selectRowAmountTotal(pagingDTO);
	}
	
	//게시물 목록 조회
	@Override
	public List<BulkVO> getBulkReplyList(PagingDTO pagingDTO) {
		return bulkMapper.selectBulkReplyList();
	}

	//게시물 등록
	@Override
	public long registerBulk(BulkVO bulk) {
		bulkMapper.insertBulk(bulk);
		
		if(bulk.getUploadFileList() == null || bulk.getUploadFileList().size() <= 0) {
			return bulk.getBno();
		}
		
		bulk.getUploadFileList().forEach(
				uploadFile -> {
					uploadFile.setBulkno(bulk.getBno());
					UploadFileMapper.insertUploadFileBulk(uploadFile);
			}				
		);
		
		return bulk.getBno();
	}

	//게시물 상세보기
	@Override
	public BulkVO getBulkDetail(long bno) {		
		return bulkMapper.selectBulkDetail(bno);
	}

	//게시물 답변 등록
	@Override
	public long registerBulkReply(BulkVO bulk) {
		bulkMapper.insertBulkReply(bulk);
		
		if(bulk.getUploadFileList() == null || bulk.getUploadFileList().size() <= 0) {
			return bulk.getRbno();
		}
		
		bulk.getUploadFileList().forEach(
				uploadFile -> {
					uploadFile.setReviewno(bulk.getRbno());
					UploadFileMapper.insertUploadFileBulk(uploadFile);
			}				
		);
		
		return bulk.getRbno();
	}

	//게시물 수정하기
	@Transactional
	@Override
	public boolean modifyBulk(BulkVO bulk) {
		
		long bno= bulk.getBno(); 
		 
		boolean modifyResult = bulkMapper.updateBulk(bulk) == 1;
		
		if(modifyResult && bulk.getUploadFileList() != null) {
			
			UploadFileMapper.deleteBoardUploadFiles(bno);
			
			bulk.getUploadFileList().forEach(
					uploadFile -> {
						uploadFile.setBulkno(bno);
						UploadFileMapper.insertUploadFileBulk(uploadFile);
					}
			);
		}
		
		return modifyResult;
	}

	//게시물 삭제하기
	@Transactional
	@Override
	public boolean deleteBulk(long bno) {
		return bulkMapper.deleteBulk(bno) == 1 ? true : false;
	}

	//업로드파일 받아오기
	@Override
	public List<UploadFileVO> getUploadFiles(long bulkno) {
		return UploadFileMapper.selectBulkFileList(bulkno);
	}

}
