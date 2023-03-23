package com.dream.mangle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dream.mangle.common.paging.PageCreateDTO;
import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.FAQboardVO;
import com.dream.mangle.service.FAQservice;

import lombok.Setter;

@Controller
@RequestMapping("/faqBoard")
public class FAQcontroller {
	
	@Setter(onMethod_ = @Autowired) //롬복 어노테이션을 이용하여 setter 방식으로 MyBoardService 의 빈이 주입되도록 지정
	private FAQservice faqService;
	
	
	  //게시물 조회 - 목록
//	@GetMapping("/list") 
//	public void getFaqList(Model model) {
//		  model.addAttribute("faqList", faqService.takeFaqList()); 
//	}
		 
	 
	
	//게시물 조회 - 목록 - 페이징 고려하기
	@GetMapping("/list")
	public void getFaqList(PagingDTO pagingDTO, Model model) {
		System.out.println("pagingDTO111111111111111111111: " + pagingDTO);
		model.addAttribute("faqList", faqService.takeFaqList(pagingDTO));
		System.out.println("pagingDTO222222222222222222222: " + pagingDTO);
		
		
		long totalRowCnt = faqService.getRowAmountTotal(pagingDTO);
		PageCreateDTO pageCreateDTO = new PageCreateDTO(totalRowCnt, pagingDTO);
		
		System.out.println("pageCreateDTO: " + pageCreateDTO);
		model.addAttribute("pageCreate", pageCreateDTO);
	}
	
	//게시물등록 - 페이지 호출
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/register")
	public void getRegisterPage() {
		
	}
	
	//게시물등록 - 처리
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/register")
	public String registerNewBoard(FAQboardVO faqBoard, RedirectAttributes redirectAttr, Model model) {

		
		int faqNo = faqService.registerFaq(faqBoard);
		redirectAttr.addFlashAttribute("result", faqNo);
		return "redirect:/faqBoard/list"; //jsp 대신, 리다이렉트 방식으로 사용자 브라우저가 게시물 목록을 호출하게 함.
	}
	
	
//	//특정 게시물 조회-수정 페이지 호출
//	@GetMapping({"/detail", "/modify"})
//	public void showBoardDetail(@RequestParam("faqNo") int faqNo, Model model) {
//	
//		model.addAttribute("faqBoard", faqService.takeFaq(faqNo));
//	
//	}
	
	//특정 게시물 조회 페이지 호출: 목록페이지에서 호출 + 게시물 상세 화면을 생성하는 JSP 페이지(detail.jsp)가 컨트롤러로부터 전달받은 페이징 데이터를 유지할 수 있도록
	//3페이지 글을 보고 있었을때 목록으로 나간 경우 3페이지 그대로 유지되도록 추가-> modelAttribute 추가
	@GetMapping("/detail")
	public void getDetail(@RequestParam("faqNo") int faqNo, Model model, 
							@ModelAttribute("pagingDTO") PagingDTO pagingDTO ) {
	
		model.addAttribute("faqBoard", faqService.takeFaq(faqNo));	
		
	}
	
	//게시물 조회페이지 -> 수정페이지 호출(/modify)
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/modify")
	public void getModify(@RequestParam("faqNo") int faqNo, Model model,
							PagingDTO pagingDTO) {
	
		model.addAttribute("faqBoard", faqService.takeDetailModify(faqNo));
		model.addAttribute("pagingDTO", pagingDTO);
	}
	
	
	//게시물 수정 후 -> 조회페이지 호출 시(/detailmod)
	@GetMapping("/detailmod")
	public String getDetailMod(@RequestParam("faqNo") int faqNo, Model model,
								PagingDTO pagingDTO) {
	
		model.addAttribute("faqBoard", faqService.takeDetailModify(faqNo));
		model.addAttribute("pagingDTO", pagingDTO);
		
	
		return "/faqBoard/detail" ;
	}
	
	//특정 게시물 수정 처리
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/modify")
	public String modifyBoard(FAQboardVO faqBoard, RedirectAttributes redirectAttr,
								PagingDTO pagingDTO){
	
		if (faqService.modifyFaq(faqBoard)) {
		redirectAttr.addFlashAttribute("result", "수정 완료");
		}
		
//		redirectAttr.addAttribute("faqNo", faqBoard.getFaqNo());
//		redirectAttr.addAttribute("pageNum", pagingDTO.getPageNum());
//		redirectAttr.addAttribute("rowPerPage", pagingDTO.getRowPerPage());
//		redirectAttr.addAttribute("scope", pagingDTO.getScope());
//		redirectAttr.addAttribute("keyword", pagingDTO.getKeyword());
//		
		return "redirect:/faqBoard/detailmod?faqNo=" + faqBoard.getFaqNo();
//		return "redirect:/myboard/detailmod" ;
	}

	//특정 게시물 삭제
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/delete")
	public String removeBoard(@RequestParam("faqNo") int faqNo, RedirectAttributes redirectAttr) {
		
		if (faqService.deleteFaqService(faqNo)) {
		redirectAttr.addFlashAttribute("result", "삭제 완료");
		}
		return "redirect:/faqBoard/list";
		}

}//
