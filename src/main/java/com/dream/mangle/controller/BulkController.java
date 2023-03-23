package com.dream.mangle.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import com.dream.mangle.domain.BulkVO;
import com.dream.mangle.domain.UploadFileVO;
import com.dream.mangle.service.BulkService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping(value="/bulk")
@Log4j
public class BulkController {
	public BulkService bulkService;
	
	//게시물 조회     완
	@GetMapping("/list")
	public void showBulkList(PagingDTO pagingDTO, Model model) {
		
		model.addAttribute("bulkList", bulkService.getBulkList(pagingDTO));
		
		model.addAttribute("reply", bulkService.getBulkReplyList(pagingDTO));
		
		PageCreateDTO pageCreateDTO = new PageCreateDTO(bulkService.getRowAmountTotal(pagingDTO), pagingDTO);
		
		model.addAttribute("pageCreate", pageCreateDTO);
		
	}
	 
	//게시물 등록		완
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void showRegistBulk() {
		
	}
	
	//post 등록		완
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String registerNewBulk(BulkVO bulk) {
		if(bulk.getUploadFileList() != null) {
			bulk.getUploadFileList()
				.forEach(uplaodFile -> System.out.println("첨부 파일 정보:" + uplaodFile.toString()));
		}
		
		System.out.println("bulk 레지스터 받은 벌크: " + bulk );
		bulkService.registerBulk(bulk);
		return "redirect:/bulk/list";
	}
	
	//특정 게시물 조회	완
	@PreAuthorize("(isAuthenticated() && principal.username == #bwriter) || hasAnyAuthority('ADMIN')")
	@GetMapping("/detail")
	public void detailBulk(long bno, String bwriter, @ModelAttribute("pagingDTO")  PagingDTO pagingDTO, Model model) {
		model.addAttribute("bulk", bulkService.getBulkDetail(bno));
	}
	
	//파일 가져오기		완
	@GetMapping(value="/getFiles", produces = "application/json;charset=utf-8")
	public ResponseEntity<List<UploadFileVO>> showUploadFiles(long bulkno){
		System.out.println("파일 bulkno:" + bulkno);
		return new ResponseEntity<List<UploadFileVO>> (bulkService.getUploadFiles(bulkno), HttpStatus.OK) ;
	}
	
	//게시물 수정페이지 호출 완
	@PreAuthorize("(isAuthenticated() && principal.username == #bwriter) || hasAnyAuthority('ADMIN')")
	@GetMapping("/modify")
	public void showModifyBulk(long bno, String bwriter, @ModelAttribute("pagingDTO") PagingDTO pagingDTO, Model model) {
		
		log.info("컨트롤러 - 게시물 조회 페이지 호출: "+ bno);
		log.info("컨트롤러 - 전달된 MyBoardPagingDTO: "+ pagingDTO);
		
		model.addAttribute("bulk",bulkService.getBulkDetail(bno));
	}
	
	//게시물 수정 등록 //야매 완
	@PreAuthorize("isAuthenticated() && principal.username == #bulk.bwriter")
	@PostMapping("/modify")
	public String modifyBulk(BulkVO bulk, RedirectAttributes redirectAttr,
							 PagingDTO pagingDTO) {
		
		System.out.println("bulk(Modify):" + bulk);
		
		if(bulkService.modifyBulk(bulk)) {
			redirectAttr.addFlashAttribute("result", "successModify");
		}
		
		redirectAttr.addFlashAttribute("bno", bulk.getBno());
		return "redirect:/bulk/detail?bno="+bulk.getBno()+"&bwriter="+bulk.getBwriter();
		
//		return "redirect:/board/bulk/callDetailBulk";
//		return "redirect:/board/bulk/callDetailBulk" + pagingDTO.addPagingParamsToURI();
	}
	
	//수정후 페이지 호출 //수정 요함
//	@PreAuthorize("(isAuthenticated() && principal.username == #bwriter) || hasAnyAuthority('ADMIN')")
	@GetMapping("/callDetailBulk")
	public String callDetailBulk(long bno, String bwriter, @ModelAttribute("pagingDTO") PagingDTO pagingDTO,Model model) {
		log.info("컨트롤러 - 게시물 조회 페이지 호출: "+ bno);
		model.addAttribute("bulk", bulkService.getBulkDetail(bno));
		
		return "/bulk/detail";		
	}
	
	//게시물 답글 등록 
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/reply")
	public void replyBulk(long bno,@ModelAttribute("pagingDTO") PagingDTO pagingDTO, Model model) {
		model.addAttribute("bulk", bulkService.getBulkDetail(bno));
	}
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/reply")
	public String registReplyBulk(long rbno,@ModelAttribute("pagingDTO") PagingDTO pagingDTO,
							RedirectAttributes redirectAttr, BulkVO bulk, Model model) {
		
		System.out.println("rbno: " + rbno);
		System.out.println("bulk: " + bulk);
		
		
		bulk.setRbno(rbno);
		
		if(bulk.getUploadFileList() != null) {
			bulk.getUploadFileList()
				.forEach(uplaodFile -> System.out.println("첨부 파일 정보:" + uplaodFile.toString()));
		}
		
		bulkService.registerBulkReply(bulk);
		
		redirectAttr.addAttribute("pageNum", pagingDTO.getPageNum());
		redirectAttr.addAttribute("RowAmountPerPage", pagingDTO.getRowPerPage());
		redirectAttr.addAttribute("scope", pagingDTO.getScope());
		redirectAttr.addAttribute("keyword", pagingDTO.getKeyword());
		
		return "redirect:/bulk/list";
	}
	
	//게시물 삭제 //완(파일 테스트 필요)
	@PreAuthorize("(isAuthenticated() && principal.username == #bwriter) || hasAnyAuthority('ADMIN')")
	@PostMapping("/remove")
	public String removeBulk(@RequestParam("bno") Long bno, String bwriter,
			RedirectAttributes redirectAttr, PagingDTO pagingDTO) {
		
		List<UploadFileVO> fileList = bulkService.getUploadFiles(bno);
		
		//DB로부터 게시물(첨부파일 포함) 정보 삭제
		
		if(bulkService.deleteBulk(bno)) {
			removeFiles(fileList);
			redirectAttr.addFlashAttribute("result", "successRemove");
		} else {
			redirectAttr.addFlashAttribute("result", "failRemove");
		}
		
		redirectAttr.addAttribute("pageNum", pagingDTO.getPageNum());
		redirectAttr.addAttribute("RowAmountPerPage", pagingDTO.getRowPerPage());
		redirectAttr.addAttribute("scope", pagingDTO.getScope());
		redirectAttr.addAttribute("keyword", pagingDTO.getKeyword());
		
		return "redirect:/bulk/list";
	}
	
	//파일 삭제 함수
	public void removeFiles(List<UploadFileVO> fileList) {
		
		if(fileList == null ||fileList.size()==0) {
			return;
		}
		
		fileList.forEach(attachFile -> {
			
			try {
				Path file = Paths.get(attachFile.getRepoPath() + "/" +
						  attachFile.getUploadPath() + "/" +
						  attachFile.getUuid() + "_" +
						  attachFile.getFileName()
						  );
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
				  Path thumbnail = Paths.get(attachFile.getRepoPath() + "/" +
						  					 attachFile.getUploadPath() + "/" +
						  					 attachFile.getUuid() + "_" +
						  					 attachFile.getFileName()
							  			    );
				  
				  Files.deleteIfExists(thumbnail);
				}
			} catch (Exception e) {
				System.out.println("오류" + e.getMessage());
			}
			
		});
	}

}