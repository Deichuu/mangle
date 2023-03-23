package com.dream.mangle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.service.StockService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping(value="/stock/*")
public class StockController {

	@Autowired
	private StockService stockService;

	
	// 상품 등록
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/add")
	public String addProdPOST(ProductVO productVO, RedirectAttributes rttr) {
		
		stockService.addProd(productVO);
		
		rttr.addFlashAttribute("add_result", productVO.getProdName());
		
		return "redirect:/stock/manage";
	}

	
	// 재고 관리 페이지
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/manage")
	public void stockPageGET(Model model) {
		model.addAttribute("prodInfo", stockService.getProdList());
	}
	

	// 재고 수량 수정
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/update")
	public String updateStockPOST(ProductVO productVO) {
		
		stockService.modifyStock(productVO);
		
		return "redirect:/stock/manage";
		
	}
	
	
	// 상품 삭제
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/delete")
	public String deleteProdPOST(ProductVO productVO) {
		
		stockService.deleteProd(productVO.getProdCode());
		
		return "redirect:/stock/manage";
		
	}
	
}