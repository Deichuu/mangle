package com.dream.mangle.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.dream.mangle.domain.NoticeVO;
import com.dream.mangle.service.NoticeService;

import lombok.Setter;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Setter(onMethod_= {@Autowired})
	private NoticeService noticeService;
	
	//목록조회
	@GetMapping("/list")
	public String showNoticList(Model model, @ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		model.addAttribute("noticeList",noticeService.selectNoticeList(pagingDTO));
		long totalRowCnt = noticeService.selectRowAmountTotal(pagingDTO);
		
		PageCreateDTO createDTO = new PageCreateDTO(totalRowCnt, pagingDTO);
		model.addAttribute("createDTO", createDTO);
		
		return "notice/notice";
	}
	
	
	//등록페이지
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/register")
	public void showNoticeRegi() {
		
	}
	
	//등록
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/register")
	public void registerNotice(NoticeVO notice) {
		noticeService.insertNotice(notice);
	}
	
	//게시물조회
	@GetMapping("/detail")
	public void showDetailNo(long noticeNo, Model model,@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		long totalRowCnt = noticeService.selectRowAmountTotal(pagingDTO);
		model.addAttribute("notice", noticeService.getNotice(noticeNo));
		
		PageCreateDTO createDTO = new PageCreateDTO(totalRowCnt, pagingDTO);
		model.addAttribute("createDTO", createDTO);
	}
	
	//수정후 상세페이지 조회로 = 조회수 유지
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/modifyDet")
	public String showView(long noticeNo, Model model ,@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		model.addAttribute("notice", noticeService.selectDetailNo(noticeNo));
		long totalRowCnt = noticeService.selectRowAmountTotal(pagingDTO);
		PageCreateDTO createDTO = new PageCreateDTO(totalRowCnt, pagingDTO);
		model.addAttribute("createDTO", createDTO);
		return "/notice/detail";
	}
	
	
	//수정페이지
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/modify")
	public void showModifyNo(long noticeNo, Model model,@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		long totalRowCnt = noticeService.selectRowAmountTotal(pagingDTO);
		System.out.println("noticeNo" + noticeNo);
		model.addAttribute("notice", noticeService.selectDetailNo(noticeNo));
		
		PageCreateDTO createDTO = new PageCreateDTO(totalRowCnt, pagingDTO);
		model.addAttribute("createDTO", createDTO);
		
	}
	
	//수정
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/modify")
	public String modifyNotice(NoticeVO notice, RedirectAttributes redirectAtt, @ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		System.out.println("pagingDTO: " + pagingDTO);
		
		if(noticeService.updateNotice(notice)) {
			redirectAtt.addFlashAttribute("result", "successModify");
		}
		redirectAtt.addAttribute("noticeNo", notice.getNoticeNo());
		redirectAtt.addAttribute("pageNum", pagingDTO.getPageNum());
		redirectAtt.addAttribute("rowPerPage", pagingDTO.getRowPerPage());
		redirectAtt.addAttribute("scope", pagingDTO.getScope());
		redirectAtt.addAttribute("keyword", pagingDTO.getKeyword());
		return "redirect:/notice/modifyDet";
	}
	
	//삭제
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/delete")
	public String deleteNotice(long noticeNo, RedirectAttributes redirectAtt,@ModelAttribute("pagingDTO") PagingDTO pagingDTO) {
		
		if(noticeService.deleteNotice(noticeNo)) {
			redirectAtt.addFlashAttribute("result","successDelete");
			redirectAtt.addAttribute("pageNum", pagingDTO.getPageNum());
			redirectAtt.addAttribute("rowPerPage", pagingDTO.getRowPerPage());
			redirectAtt.addAttribute("scope", pagingDTO.getScope());
			redirectAtt.addAttribute("keyword", pagingDTO.getKeyword());
		}else {
			redirectAtt.addFlashAttribute("result","fail");
		}
		return "redirect:/notice/list";
	}
}
