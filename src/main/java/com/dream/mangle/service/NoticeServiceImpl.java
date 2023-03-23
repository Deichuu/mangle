package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.NoticeVO;
import com.dream.mangle.mapper.NoticeMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService{
	
	private NoticeMapper noticeMapper;
	

	
	@Override
	public List<NoticeVO> selectNoticeList(PagingDTO pagingDTO) {
		return noticeMapper.selectNoticeList(pagingDTO);
	}

	@Override
	public NoticeVO selectDetailNo(long noticeNo) {
		return noticeMapper.selectDetailNo(noticeNo);
	}

	@Override
	public long insertNotice(NoticeVO notice) {
		noticeMapper.insertNotice(notice);
		return notice.getNoticeNo();
	}

	@Override
	public boolean deleteNotice(long noticeNo) {
		return noticeMapper.deleteNotice(noticeNo) == 1;
		//수정된 행수가 1이면 trues
	}

	@Override
	public boolean updateNotice(NoticeVO notice) {
		return noticeMapper.updateNotice(notice) == 1 ;
	}
	
	//조회수 1 올리고, 상세조회
	@Override
	public NoticeVO getNotice(long noticeNo) {
		noticeMapper.upView(noticeNo);
		return noticeMapper.selectDetailNo(noticeNo);
	}

	@Override
	public long selectRowAmountTotal(PagingDTO PagingDTO) {
		return noticeMapper.selectRowAmountTotal(PagingDTO);
	}

	@Override
	public NoticeVO getViewMod(long noticeNo) {
		return noticeMapper.selectDetailNo(noticeNo) ;
	}



}
