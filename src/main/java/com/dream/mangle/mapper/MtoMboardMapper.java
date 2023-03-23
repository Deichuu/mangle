package com.dream.mangle.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.MtoMboardVO;

public interface MtoMboardMapper {
	//게시물 조회 - 목록
    //public List<MyBoardVO> selectMyBoardList();
	public List<MtoMboardVO> selectBoardList(PagingDTO boardPagingDTO);
	
	public long selectTotalRowCnt(PagingDTO boardPagingDTO);
	
	public List<MtoMboardVO> selectReplyList();
	
	
    //게시물 등록1 - selectKey 이용 않함
    //public int insertMyBoard(MyBoardVO myBoard);
	
	
    //게시물 등록2 - selectKey 이용
    public int insertBoardSelectKey(MtoMboardVO board);
    
    //게시물 답글 등록 - selectKey 이용
    public int insertMtomReply(MtoMboardVO board);
	
    
    //특정 게시물 조회 
    public MtoMboardVO selectBoard(long bno);
    
    
    //특정 게시물 수정
    public int updateBoard(MtoMboardVO board);
    
    
    //특정 게시물 삭제 - 실제 삭제 
    public int deleteBoard(long bno);

    
    //특정 게시물 삭제 요청 - 해당 글의 bdelFlag을 1로 수정 
    public int updateBdelFlag(long bno);
	
    
    //게시물 삭제(관리자) – 사용자 삭제 요청된 게시물(bdelFlag = 1) 전체 삭제
    //public int deleteAllBoardSetDeleted();

    
    //특정 게시물 조회수 증가
    public void updateBviewsCnt(long bno);
    
    
    //특정 게시물 댓글/답글 수 변경: 삭제 시 -1, 추가 시 +1 
    public void updateBReplyCnt(@Param("bno") long bno, @Param("amount") int amount);
}
