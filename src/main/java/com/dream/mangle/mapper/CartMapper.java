package com.dream.mangle.mapper;

import java.util.List;

import com.dream.mangle.common.cart.CartDTO;
import com.dream.mangle.domain.CartVO;

public interface CartMapper {

	//카트 추가
	public int addCart(CartVO cart);
	
	//카트 삭제
	public int deleteCart(int cartId);
	
	//카트 수량 수정
	public int modifyAmount(CartDTO cartDTO);
	
	//카트 목록
	public List<CartDTO> getCart(String userEmail);	
	
	//카트 확인
	public int checkCart(CartVO cart);

	
}