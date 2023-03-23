package com.dream.mangle.service;

import java.util.List;

import com.dream.mangle.common.cart.CartDTO;
import com.dream.mangle.domain.CartVO;

public interface CartService {

	// 장바구니 추가
	public boolean addCart(CartVO cart);

	// 장바구니 정보 리스트 
	public List<CartDTO> getCartList(String userEmail);
	
	// 카트 수량 수정
	public int modifyAmount(CartDTO cartDTO);
	
	// 카트 삭제
	public int deleteCart(int cartId);
	
	//장바구니 존재 확인
	public int checkCart(CartVO cart);
	
}