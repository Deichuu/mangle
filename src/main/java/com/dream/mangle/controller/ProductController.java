package com.dream.mangle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.mangle.service.ProdDetailService;
import com.dream.mangle.service.ProductService;

import lombok.AllArgsConstructor;

@RequestMapping("/detail/*")
@Controller
@AllArgsConstructor
public class ProductController {
	
	private ProductService productService;
	private ProdDetailService prodDetailService;
	
	@GetMapping("/main")
	public void getProdDetail(String prodCode, Model model) {
		model.addAttribute("product", productService.selectProd(prodCode));
		model.addAttribute("rating", productService.selectRatingAvg());
		System.out.println("controller전: " + prodCode);
		model.addAttribute("prod", prodDetailService.selectProdScript(prodCode) );
		System.out.println("controller후 ");
		
	}
	
}