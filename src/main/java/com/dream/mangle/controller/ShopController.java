package com.dream.mangle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.mangle.common.paging.ShopPageCreateDTO;
import com.dream.mangle.common.paging.ShopPagingDTO;
import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.service.ShopService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/shop")
public class ShopController {
	
	private ShopService shopService;
	
	@GetMapping("/list")
	public void getAllProd(Model model, ShopPagingDTO pagingDTO){
		System.out.println("======================================pagingDTO2========================================================" + pagingDTO);		
		
//		long totalRowCnt = shopService.selectRowAmountTotal(pagingDTO);
		String title = "";
		String subtitle = "";
		if(pagingDTO.getCategorized() == null || pagingDTO.getCategorized().equals("")) {
			pagingDTO.setCategorized("1") ;
			pagingDTO.setCitemtype("1");
		}
		
		if(pagingDTO.getProducer() == null || pagingDTO.getProducer().equals("")) {
			
		} else if(pagingDTO.getProducer().contains("삼성")) {
			subtitle = "삼성";
		} else if(pagingDTO.getProducer().contains("애플")) {
			subtitle = "애플";			
		}
		
		pagingDTO.setProducer(subtitle);
		ShopPageCreateDTO createDTO = new ShopPageCreateDTO(shopService.selectRowAmountTotal(pagingDTO), pagingDTO);		
		
		if(pagingDTO.getCategorized().equals("1")) {
			title = "스마트폰 케이스";
			
			if(pagingDTO.getCitemtype().equals("1")) {
				subtitle += " 일반";
			} else if(pagingDTO.getCitemtype().equals("2")) {
				subtitle += " 사진 케이스(업로드)";
			} else if(pagingDTO.getCitemtype().equals("3")) {
				subtitle += " 커스텀";
			}
			
		} else if (pagingDTO.getCategorized().equals("3")) {
			title = "이어폰 케이스";
			
		} else if (pagingDTO.getCategorized().equals("2")) {
			title = "그립톡";
		}
		
		model.addAttribute("prod",shopService.selectAllProd(pagingDTO));
		model.addAttribute("pagingDTO",pagingDTO);
		model.addAttribute("createDTO",createDTO);
		model.addAttribute("title", title);
		model.addAttribute("subtitle", subtitle);
	}
	
	@GetMapping("/shopCate")
	public String getAccType(ProductVO product, Model model) {
		model.addAttribute("prod",shopService.selectCateType(product));
		return "/shop/list";
	}
	
	//작가중개 페이지
	@GetMapping("/illustrator")
	public void getIllustrator() {
		System.out.println("작가중개 페이지 호출");
	}
	
//	@GetMapping("/shopproducer")
//	public String getProducer(Model model, PagingDTO2 pagingDTO2) {
//
//		model.addAttribute("prod", shopService.selectProducer(pagingDTO2));
//		
//		long totalRowCnt = shopService.selectRowAmountTotal(pagingDTO2);
//		PageCreateDTO2 createDTO2 = new PageCreateDTO2(totalRowCnt, pagingDTO2);
//		model.addAttribute("createDTO2",createDTO2);
//		return "mangle/shop";
//	}
	
//	@GetMapping("/shoprow")
//	public String getRow(Model model, PagingDTO2 pagingDTO2) {
//		model.addAttribute("row",shopService.selectRow(pagingDTO2));
//		
//		long totalRowCnt = shopService.selectRowAmountTotal(pagingDTO2);
//		PageCreateDTO2 createDTO2 = new PageCreateDTO2(totalRowCnt, pagingDTO2);
//		model.addAttribute("createDTO2",createDTO2);
//		return "mangle/shop";
//	}
//	
//	@GetMapping("/shophigh")
//	public String getHigh(Model model, PagingDTO2 pagingDTO2) {
//		model.addAttribute("high", shopService.selectHigh(pagingDTO2));
//		
//		long totalRowCnt = shopService.selectRowAmountTotal(pagingDTO2);
//		PageCreateDTO2 createDTO2 = new PageCreateDTO2(totalRowCnt, pagingDTO2);
//		model.addAttribute("createDTO2",createDTO2);
//		return "mangle/shop";
//	}
//	
//	@GetMapping("/shoppop")
//	public String getPop(Model model, PagingDTO2 pagingDTO2) {
//		model.addAttribute("pop", shopService.selectPop(pagingDTO2));
//		
//		long totalRowCnt = shopService.selectRowAmountTotal(pagingDTO2);
//		PageCreateDTO2 createDTO2 = new PageCreateDTO2(totalRowCnt, pagingDTO2);
//		model.addAttribute("createDTO2",createDTO2);
//		return "mangle/shop";
//	}
	

}
