package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.NoticeVO;

public interface NoticeMapper {

	//공지사항 목록 조회
	public List<NoticeVO> selectNoticeList(PagingDTO pagingDTO);
	
	//페이징
	public long selectRowAmountTotal(PagingDTO PagingDTO);
	
	//공지 1개 조회
	public NoticeVO selectDetailNo(long noticeNo);
	
	//공지 등록
	public int insertNotice(NoticeVO notice);
	
	//공지 삭제
	public int deleteNotice(long noticeNo);
	
	//공지 수정
	public int updateNotice(NoticeVO notice);
	
	//공지 조회수 증가
	public void upView(long noticeNo);
	
	
}
