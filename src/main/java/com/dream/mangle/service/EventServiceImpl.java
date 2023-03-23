package com.dream.mangle.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.EventVO;
import com.dream.mangle.mapper.EventMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class EventServiceImpl implements EventService{
	private EventMapper mapper;
	
	@Override
	public List<EventVO> selectEventList(PagingDTO pagingDTO) {
		return mapper.selectEventList(pagingDTO);
	}

	@Override
	public EventVO selectOneEvent(int eventno) {
		return mapper.selectOneEvent(eventno);
	}

	@Override
	public int insertEventKey(EventVO eventVO) {
		return mapper.insertEventKey(eventVO);
	}

	@Override
	public boolean updateEventEndFlag(int eventno) {
		return mapper.updateEventEndFlag(eventno) == 1;
	}

	@Override
	public void updateView(int eventno) {
		mapper.updateViewEvent(eventno);
	}

	@Override
	public boolean updateEvent(EventVO eventVO) {
		return mapper.updateEvent(eventVO) == 1;
	}

	@Override
	public int allCnt() {
		return mapper.selectAllCountEvent();
	}
	
	
}
