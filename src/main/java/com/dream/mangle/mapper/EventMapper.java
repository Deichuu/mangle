package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.EventVO;

public interface EventMapper {
	
//	public List<EventVO> selectEventList();//전체리스트
	public List<EventVO> selectEventList(PagingDTO pagingDTO);//전체리스트
	
	public EventVO selectOneEvent(int eventno);//한 행 부르기
	
	public int insertEventKey(EventVO eventVO);//새 글 넣기
	
	public int updateEventEndFlag(int eventno);//끝난 이벤트 처리
	
	public void updateViewEvent(int eventno);//조회수 증가
	
	public int updateEvent(EventVO eventVO);//글 수정
	
	public int selectAllCountEvent();//게시글 총 개수
}
