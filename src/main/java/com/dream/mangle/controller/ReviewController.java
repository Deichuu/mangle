package com.dream.mangle.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dream.mangle.common.paging.ReviewPageCreateDTO;
import com.dream.mangle.common.paging.ReviewPagingDTO;
import com.dream.mangle.domain.ReviewVO;
import com.dream.mangle.domain.UploadFileVO;
import com.dream.mangle.service.ReviewService;

import lombok.AllArgsConstructor;

@RequestMapping(value= {"/reviews"})
@RestController
@AllArgsConstructor
public class ReviewController {
	
	private ReviewService reviewService;	
	//댓글 목록
	@GetMapping(value="/{prodCode}/page/{page}" ,
			produces= {"application/json; charset=UTF-8"} )
	public ResponseEntity<ReviewPageCreateDTO> showReviews(@PathVariable(value="prodCode") String prodCode,
															@PathVariable(value="page") int pageNum, Model model){
		
		ReviewPageCreateDTO reviewPagingCreator =
				reviewService.SelectReview(new ReviewPagingDTO(prodCode, pageNum));
		
		return new ResponseEntity<ReviewPageCreateDTO>(reviewPagingCreator, HttpStatus.OK);
	}
	
	//댓글 등록
	@PostMapping(value = "/{prodCode}/new",
				 produces = "text/plain; charset=utf-8" ,
				 consumes = "application/json; charset=utf-8")
	public ResponseEntity<String> registerReview (@PathVariable(value = "prodCode") String prodCode,
												  @RequestBody ReviewVO review) {		

		return (reviewService.RegistReview(review) == true)?
						  new ResponseEntity<String>("RegisterSuccess", HttpStatus.OK) 
						: new ResponseEntity<String>("RegisterFail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@RequestMapping(value  = "/{prodCode}/{rno}",
					method = {RequestMethod.PATCH, RequestMethod.PUT},
					consumes = "application/json;charset=UTF-8",
					produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> modifyReview (@PathVariable("rno") long rno,
												@RequestBody ReviewVO reviewVO) {
		
		return reviewService.ModifyReview(reviewVO) == true ?
				new ResponseEntity<String>("ModifySuccess", HttpStatus.OK) : 
				new ResponseEntity<String>("ModifyFail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 삭제	
	@DeleteMapping(value="/{prodCode}/{rno}", produces= {"text/plain; charset=utf-8"})
	public ResponseEntity<String > removeReview (@PathVariable("prodCode") String prodCode,
												 @PathVariable("rno") long rno) {
		
		return reviewService.removeReview(rno,prodCode) == true ?
				new ResponseEntity<String>("removeSuccess", HttpStatus.OK) : 
				new ResponseEntity<String>("removeFail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//파일 가져오기
	@GetMapping(value="/getFile/{reviewno}",
				produces = "application/json;charset=utf-8")
	public ResponseEntity<UploadFileVO> showUploadFile(@PathVariable long reviewno){
		System.out.println("파일 reviewno:" + reviewno);
		
		UploadFileVO result = reviewService.getImageFile(reviewno);
		return new ResponseEntity<UploadFileVO> (result, HttpStatus.OK); 
	}
	
	//좋아요 상승
	@RequestMapping(value  = "/{rno}/like",
					consumes = "application/json;charset=UTF-8",
					produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> likeUp (@PathVariable("rno") long rno) {
			
			
			
		return reviewService.likeUp(rno) == true ?
				new ResponseEntity<String>("likeSuccess", HttpStatus.OK) : 
				new ResponseEntity<String>("likeFail", HttpStatus.INTERNAL_SERVER_ERROR);
		}

}
