package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.MtoMboardVO;
import com.dream.mangle.domain.UploadFileVO;

public interface MtoMboardService {

	//게시물 조회 - 목록
	//public List<BoardVO> getBoardList();
    public List<MtoMboardVO> getBoardList(PagingDTO boardPagingDTO);
    
    public long getTotalRowCnt(PagingDTO boardPagingDTO) ;
	
    public List<MtoMboardVO> getReplyList();
    
    //게시물 등록 - selectKey 이용
    public Long registerBoard(MtoMboardVO board);
    
    
    //답글 등록 - selectKey 이용
    public Long registerReply(MtoMboardVO board);
    
        
    //특정 게시물 조회(조회수 증가 고려)
    public MtoMboardVO getBoard(long bno);
    
	//특정 게시물 조회 시, 게시물의 첨부파일 정보를 조회
    public List<UploadFileVO> getAttachFiles(long mtombno) ;
    
    //게시물 조회: 게시물 조회 페이지 -> 게시물 수정 페이지 호출(by bno), 조회수 변화 없음
    //게시물 조회: 게시물 수정 후 -> 게시물 조회 페이지 호출(by bno), 조회수 증가 없음
    public MtoMboardVO getBoardDetailModify(long bno) ;
    
    //특정 게시물 수정
    public boolean modifyBoard(MtoMboardVO board);
    
    //특정 게시물 삭제 - 실제 삭제 
    public boolean removeBoard(long bno);

    //특정 게시물 삭제 요청 - 해당 글의 bdelFlag을 1로 수정 
    public boolean setBoardDeleted(long bno);
	
    //게시물 삭제(관리자) – 사용자 삭제 요청된 게시물(bdelFlag = 1) 전체 삭제
    //public int removeAllDeletedBoard();
}
