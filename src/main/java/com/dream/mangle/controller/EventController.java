package com.dream.mangle.controller;


import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dream.mangle.common.paging.PageCreateDTO;
import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.EventVO;
import com.dream.mangle.mapper.UploadFileMapper;
import com.dream.mangle.service.EventService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/event/*")
public class EventController {
	
	private EventService eventService;
	private UploadFileMapper fileMapper;
	
	@GetMapping("/list")
	public void getEventList(PagingDTO pagingDTO,Model model){
		
		model.addAttribute("eventList", eventService.selectEventList(pagingDTO));
		
		int totalCnt = eventService.allCnt();
		PageCreateDTO createDTO = new PageCreateDTO(totalCnt, pagingDTO);
		System.out.println("컨트롤러에서 생성된 createDTO 객체 정보: " + createDTO.toString());
		model.addAttribute("createDTO", createDTO);
	}
	
	@GetMapping("/detail")
	public void getOneEvent(int eventNo, Model model, @ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		eventService.updateView(eventNo);
		model.addAttribute("oneEvent", eventService.selectOneEvent(eventNo));
		model.addAttribute("imageFile", fileMapper.selectUploadFileList(eventNo));
	}
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/register")
	public void registPage() {
		System.out.println("등록페이지 호출");
	}
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/register")
	public String registEvent(EventVO eventVO, RedirectAttributes attributes) {
//		System.out.println("eventVO전: "+eventVO);
		eventService.insertEventKey(eventVO);
//		System.out.println("eventVO후: "+eventVO);
		int eventNo = eventVO.getEventNo();
		
		if(eventVO.getUploadFileList() != null) {
			eventVO.getUploadFileList().forEach(fileVO -> {
				fileVO.setEventNo(eventNo);
				fileMapper.insertUploadFileEvent(fileVO);
			});
		}
		
		System.out.println("글번호: "+ eventNo);
		attributes.addFlashAttribute("result", "success");	
		
		return "redirect:/event/list";
	}
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/modify")
	public void modifyPage(int eventNo, Model model, @ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		model.addAttribute("oneEvent", eventService.selectOneEvent(eventNo));
	}
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/modify")
	public String modifyEvent(EventVO eventVO, RedirectAttributes attributes, @ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		if(eventService.updateEvent(eventVO)) {
			attributes.addFlashAttribute("result", "success");
		}else {
			attributes.addFlashAttribute("result", "fail");
		}
		attributes.addAttribute("bno", eventVO.getEventNo());
		attributes.addAttribute("pageNum", pagingDTO.getPageNum());
		attributes.addAttribute("rowAmountPerPage", pagingDTO.getRowPerPage());
		return "redirect:/event/detail?eventNo="+eventVO.getEventNo();
	}
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/end")
	public String endEvent(int eventNo, RedirectAttributes attributes, @ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		if(eventService.updateEventEndFlag(eventNo)) {
			attributes.addFlashAttribute("result", "success");
		}else {
			attributes.addFlashAttribute("result", "fail");
		}
		return "redirect:/event/list";
	}
	
	
}
