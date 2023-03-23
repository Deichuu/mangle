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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dream.mangle.common.paging.PageCreateDTO;
import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.MtoMboardVO;
import com.dream.mangle.domain.UploadFileVO;
import com.dream.mangle.service.MtoMboardService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor // myBoardService 필드에 서비스 객체를 주입하기 위해 사용됨
@RequestMapping(value="/mtomboard/*")
public class MtoMboardController {
public MtoMboardService boardService ;

	
	//목록 조회				GET /myboard/list
	@GetMapping("/list")
	public void showBoardList(PagingDTO boardPagingDTO, Model model ) {
		
		model.addAttribute("boardList", boardService.getBoardList(boardPagingDTO)) ;
		
		model.addAttribute("reply", boardService.getReplyList());
		
		long totalRowCnt = boardService.getTotalRowCnt(boardPagingDTO) ;
		
		PageCreateDTO boardPagingCreatorDTO 
					= new PageCreateDTO(totalRowCnt, boardPagingDTO) ;
		model.addAttribute("pagingCreator", boardPagingCreatorDTO) ;
		
	}
	
	
	//등록 페이지 호출		GET /myboard/register
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void showBoardRegisterPage() {
		
	}
	
	
	//등록 처리				POST /myboard/register
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String registerNewBoard(MtoMboardVO board, RedirectAttributes redirectAttr) {
		
		System.out.println("컨트롤러 - 게시물등록(전달된 VO): " + board.toString());
		System.out.println("============= attachInfo =============");
		if (board.getUploadFileList() != null) {
			board.getUploadFileList()
				.forEach(attachFile -> System.out.println("첨부 파일 정보:" + attachFile.toString()));
		}
		System.out.println("===========================================");
		
		
		Long bno = boardService.registerBoard(board) ;
		System.out.println("등록된 게시물 bno: " + bno);
		
		redirectAttr.addFlashAttribute("result", bno) ;
		System.out.println("mtomboard.jsp로 전달되는 result: " + redirectAttr.getAttribute("result"));
		
		return "redirect:/mtomboard/list" ; 
	}
	
	
	//특정 게시물 조회		GET /myboard/detail
	@PreAuthorize("(isAuthenticated() && principal.username == #bwriter) || hasAnyAuthority('ADMIN')")
	@GetMapping("/detail")
	public void showBoardDetail(Long bno, String bwriter, @ModelAttribute("boardPagingDTO") PagingDTO boardPagingDTO, Model model) {
		//System.out.println("사용자가 컨트롤러로 전달한 bno: " + bno) ;

		model.addAttribute("board", boardService.getBoard(bno)) ;
		model.addAttribute("boardPagingDTO", boardPagingDTO) ;
		//System.out.println("컨트롤러: 서비스로부터 전달된 MyBoardVO: " + model.getAttribute("board")) ;
	}
	
	
	@GetMapping(value="/getFiles" , produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public ResponseEntity<List<UploadFileVO>> showUploadFiles(long mtombno){
		
		return new ResponseEntity<List<UploadFileVO>>(boardService.getAttachFiles(mtombno), HttpStatus.OK) ;
		
	}
	

	//수정 페이지 호출		GET /myboard/register
	//@PreAuthorize("(isAuthenticated() && principal.username == #bwriter) || hasAnyAuthority('ADMIN')") //detail.jsp의 수정 버튼 클릭 이벤트 화면으로부터 bwriter
	@GetMapping("/modify")
	public void showBoardModify(Long bno, String bwriter, @ModelAttribute("boardPagingDTO") PagingDTO boardPagingDTO, Model model) {
		//System.out.println("컨트롤러 - 게시물 수정 페이지 호출: "+ bno);
		//System.out.println("컨트롤러 - 전달된 MyBoardPagingDTO: "+ boardPagingDTO);
		
		model.addAttribute("board", boardService.getBoardDetailModify(bno)) ;
	}
	
	
	//수정 후, 상세 페이지 호출		GET /myboard/register
	//@PreAuthorize("(isAuthenticated() && principal.username == #bwriter) || hasAnyAuthority('ADMIN')")
	@GetMapping("/detailmod")
	public String showBoardDetailMod(Long bno, String bwriter, @ModelAttribute("boardPagingDTO") PagingDTO boardPagingDTO, Model model) {
		//System.out.println("컨트롤러 - 게시물 수정 페이지 호출: "+ bno);
		//System.out.println("컨트롤러 - 전달된 MyBoardPagingDTO: "+ boardPagingDTO);
		
		model.addAttribute("board", boardService.getBoardDetailModify(bno)) ;
		
		return "/mtomboard/detail" ;
	}
	
	
	//특정 게시물 수정		POST /myboard/modify
	@PreAuthorize("isAuthenticated() && principal.username == #board.bwriter")
	@PostMapping("/modify")
	public String modifyBoard(MtoMboardVO board, 
							  RedirectAttributes redirectAttr,
							  PagingDTO boardPagingDTO) {
		
		if(boardService.modifyBoard(board)) {
			redirectAttr.addFlashAttribute("result", "successModify") ;
			
		}
		//return "redirect:/myboard/detail?bno=" + myBoard.getBno() ;
		
		redirectAttr.addAttribute("bno", board.getBno()) ;
		
		return "redirect:/mtomboard/detail?bno="+board.getBno()+"&bwriter="+board.getBwriter(); 
		//return "redirect:/mtomboard/detailmod"  + boardPagingDTO.addPagingParamsToURI();
	}
	
	
	//특정 게시물 삭제		POST /myboard/remove
	@PreAuthorize("(isAuthenticated() && principal.username == #bwriter) || hasAnyAuthority('ADMIN')")
	@PostMapping("/remove")
	public String removeBoard(@RequestParam("bno") Long bno, 
							  String bwriter, 
							  RedirectAttributes redirectAttr, 
							  PagingDTO boardPagingDTO) {

		//첨부파일 정보가 저장된 리스트 객체 생성
		List<UploadFileVO> fileList = boardService.getAttachFiles(bno) ;
		
		//DB로부터 게시물(첨부파일 포함) 정보 삭제
		if(boardService.removeBoard(bno)) {
			removeAttachFiles(fileList) ;
			redirectAttr.addFlashAttribute("result", "successRemove") ;
			
		} else {
			redirectAttr.addFlashAttribute("result", "failRemove") ;
		}
		
		redirectAttr.addAttribute("pageNum", boardPagingDTO.getPageNum());
		redirectAttr.addAttribute("rowPerPage", boardPagingDTO.getRowPerPage()) ;
		redirectAttr.addAttribute("scope", boardPagingDTO.getScope()) ;
		redirectAttr.addAttribute("keyword", boardPagingDTO.getKeyword()) ;
		
		
		return "redirect:/mtomboard/list" ;
	}


	//특정 게시물 삭제의뢰		POST /myboard/delete
//	@PreAuthorize("isAuthenticated() && principal.username == #bwriter")
	@PostMapping("/delete")
	public String deleteBoard(@RequestParam("bno") Long bno, 
							  String bwriter, 
							  RedirectAttributes redirectAttr, 
							  PagingDTO boardPagingDTO) {
		
		//System.out.println("bwriter: " + bwriter);
		
		//첨부파일 정보가 저장된 리스트 객체 생성
		List<UploadFileVO> fileList = boardService.getAttachFiles(bno) ;
		
		
		if(boardService.setBoardDeleted(bno)) {
			//removeAttachFiles(attatchFileList) ; //실제 파일 삭제를 막기 위해서 주석처리 됨
			redirectAttr.addFlashAttribute("result", "successRemove") ;
		} else {
			redirectAttr.addFlashAttribute("result", "failRemove") ;
		}
		
		redirectAttr.addAttribute("pageNum", boardPagingDTO.getPageNum());
		redirectAttr.addAttribute("rowPerPage", boardPagingDTO.getRowPerPage()) ;
		redirectAttr.addAttribute("scope", boardPagingDTO.getScope()) ;
		redirectAttr.addAttribute("keyword", boardPagingDTO.getKeyword()) ;
		
		
		return "redirect:/mtomboard/list" ;
	}
  

	private void removeAttachFiles(List<UploadFileVO> fileList) {
		
		if (fileList == null || fileList.size() == 0) {
			return ;
		}
		
		fileList.forEach(attachFile -> {
			Path file = Paths.get(attachFile.getRepoPath() + "/" +
								  attachFile.getUploadPath() + "/" +
								  attachFile.getUuid() + "_" +
								  attachFile.getFileName()
		                         ) ;
			try {
				Files.deleteIfExists(file) ;
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbnail = Paths.get(attachFile.getRepoPath() + "/" +
							  				   attachFile.getUploadPath() + "/s_" +
							  				   attachFile.getUuid() + "_" +
							  				   attachFile.getFileName()
				           ) ;
					Files.delete(thumbnail) ;
				}
				
			} catch (Exception e) {
				System.out.println("오류: " + e.getMessage());
			}
		});	
	}

	
	//게시물 답글 등록 
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/reply")
	public void reply(long bno,@ModelAttribute("boardPagingDTO") PagingDTO boardPagingDTO, Model model) {
		model.addAttribute("board", boardService.getBoard(bno));
	}
	

	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/reply")
	public String registReplyBulk(long rbno,@ModelAttribute("boardPagingDTO") PagingDTO boardPagingDTO,
							RedirectAttributes redirectAttr, MtoMboardVO board, Model model) {
		
		System.out.println("rbno: " + rbno);
		System.out.println("board: " + board);
		
		
		board.setBno(rbno);
		
		if(board.getUploadFileList() != null) {
			board.getUploadFileList()
				.forEach(uplaodFile -> System.out.println("첨부 파일 정보:" + uplaodFile.toString()));
		}
		
		boardService.registerReply(board);
		
		redirectAttr.addAttribute("pageNum", boardPagingDTO.getPageNum());
		redirectAttr.addAttribute("RowPerPage", boardPagingDTO.getRowPerPage());
		redirectAttr.addAttribute("scope", boardPagingDTO.getScope());
		redirectAttr.addAttribute("keyword", boardPagingDTO.getKeyword());
		
		return "redirect:/mtomboard/list";
	}
}
