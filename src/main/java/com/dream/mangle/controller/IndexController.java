package com.dream.mangle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.mangle.domain.ProductVO;
import com.dream.mangle.service.ProductService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping(value="/shop/*")
public class IndexController {
	
	public ProductService productService ;

	//index 페이지 조회
	@GetMapping("/index")
	public void showIndex(ProductVO productVO, Model model) {
		
		model.addAttribute("product", productService.selectRatingAvg());
		
	}

	
}