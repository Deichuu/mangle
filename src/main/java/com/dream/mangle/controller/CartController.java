package com.dream.mangle.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dream.mangle.common.cart.CartDTO;
import com.dream.mangle.domain.CartVO;
import com.dream.mangle.service.CartService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping(value="/cart/*")
public class CartController {

	@Autowired
	private CartService cartService;
	
	//장바구니 추가
	@PreAuthorize("isAuthenticated() && principal.username == #cart.userEmail")
	@PostMapping("/add")
	@ResponseBody
	
	public ResponseEntity<String> addCartPOST(CartVO cart, HttpServletRequest request) {

		String result = "";
		// 카트 등록
		if(cartService.addCart(cart)) {
			result = "y";
		}else {
			result = "n";
		}
		
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	//장바구니 목록
	@PreAuthorize("isAuthenticated() && principal.username == #userEmail")
	@GetMapping("/cartlist")
	public void cartPageGET(String userEmail, Model model) {
		model.addAttribute("memberInfo", userEmail);
		model.addAttribute("cartInfo", cartService.getCartList(userEmail));
		
	}
	

	// 장바구니 수량 수정
	@PreAuthorize("isAuthenticated() && principal.username == #cartDTO.userEmail")
	@GetMapping("/update")
	public String updateCartPOST(CartDTO cartDTO) {
		System.out.println("cartDTO: "+cartDTO);
		cartService.modifyAmount(cartDTO);
		
		return "redirect:/cart/cartlist?userEmail="+cartDTO.getUserEmail();		
	}	
	
	// 장바구니 삭제
	@PreAuthorize("isAuthenticated() && principal.username == #cartDTO.userEmail")
	@PostMapping("/delete")
	public String deleteCartPOST(CartDTO cartDTO) {		
		cartService.deleteCart(cartDTO.getCartId());
		
		return "redirect:/cart/cartlist?userEmail=" + cartDTO.getUserEmail();		
	}
	
	//장바구니 확인
	@ResponseBody
	@PostMapping("/check")
	public ResponseEntity<String> checkCart(CartVO cart) {
		String result="";
		if(cartService.checkCart(cart) == 1) {
			result = "y";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
}