package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.NoticeVO;

public interface NoticeService {
	
	//목록조회
	public List<NoticeVO> selectNoticeList(PagingDTO pagingDTO);
	
	//페이징
	public long selectRowAmountTotal(PagingDTO PagingDTO);
	
	//공지 1개 조회
	public NoticeVO selectDetailNo(long noticeNo);
	
	//공지 등록
	public long insertNotice(NoticeVO notice);
	
	//공지 삭제
	public boolean deleteNotice(long noticeNo);
	
	//공지 수정
	public boolean updateNotice(NoticeVO notice);
	
	//조회수 + 상세조회
	public NoticeVO getNotice(long noticeNo);
	
	//조회수 수정하기
	public NoticeVO getViewMod(long noticeNo);
	
}
