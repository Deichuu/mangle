package com.dream.mangle.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dream.mangle.common.cart.CartDTO;
import com.dream.mangle.domain.CartVO;
import com.dream.mangle.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartMapper cartMapper;	
	
	public boolean addCart(CartVO cart) {
		if(cartMapper.addCart(cart) == 1) {
			return true;
		}else {
			return false;
		}
	}	

	public List<CartDTO> getCartList(String userEmail){		
		List<CartDTO> cartDTO = cartMapper.getCart(userEmail);		
		for(CartDTO dto : cartDTO) {
			dto.totalPrice();
		}		
		return cartDTO;
	}	
	
	@Override
	public int modifyAmount(CartDTO cartDTO) {		
		return cartMapper.modifyAmount(cartDTO);
	}	
	
	@Override
	public int deleteCart(int cartId) {
		return cartMapper.deleteCart(cartId);
	}

	@Override
	public int checkCart(CartVO cart) {
		return cartMapper.checkCart(cart);
	}
	
}