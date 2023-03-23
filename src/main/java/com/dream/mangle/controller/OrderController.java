package com.dream.mangle.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.mangle.domain.AddressVO;
import com.dream.mangle.domain.OrderSelectVO;
import com.dream.mangle.domain.OrderVO;
import com.dream.mangle.service.OrderService;

import lombok.Setter;

@Controller
@RequestMapping("/order")
public class OrderController {

	@Setter (onMethod_=@Autowired)
	private OrderService orderService;
		
	//주문정보 입력 페이지 호출
	@PreAuthorize("isAuthenticated() && principal.username == #userEmail")
	@GetMapping("/orderinfo")
	public void getOrder(Model model, String userEmail) {
		model.addAttribute("fromCart", orderService.selectNamePriceService(userEmail));
		model.addAttribute("userEmail", userEmail);
		model.addAttribute("memberInfo", orderService.selectPointCoupon(userEmail));
		model.addAttribute("addressList", orderService.selectUserAddress(userEmail));
	}
	
	//주문정보 페이지 호출
//	@GetMapping("orderinfo")
//	public void getOrder() {
//		
//	}
	

//	//주문요약=카트목록 끌어오기
//	public List<ProductVO> getNamePrice(Model model, String userEmail) {
//		return 
////		model.addAttributes("fromCart", orderService.selectNamePriceService(userEmail));
//	}
	
	//주문정보 입력하기 --정보 입력 후 주문내역으로 가게 하기.
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/orderinfo")
	public String getOrder(OrderVO order, AddressVO Adreess) {
		System.out.println("order:" + order);
		System.out.println("Adreess:" + Adreess);
		order.setAddress(Adreess);		
		orderService.insertOrderService(order);
		
		return "redirect:/order/myorderlist?orderId="+order.getOrderId()
	 	 		+ "&userEmail="+order.getUserEmail();
	}
	
	//주문상세 정보
	
	
	 // 모든 회원의 주문내역 조회 - 목록
//	@PreAuthorize("isAuthenticated()")
//	@GetMapping("/list") 
//	public void getOrderList( Model model) {
//		  model.addAttribute("orderList", orderService.selectServiceList());
//	}
//	
	
	//주문내역 조회 (회원 orderId로 조회)
	@PreAuthorize("isAuthenticated() && principal.username == #userEmail")
	@GetMapping("/myorderlist")
	public void getMyOrderList( Model model, String userEmail, String orderId, HttpServletRequest httr) {
		OrderVO myOrder = orderService.selectMyOrderService(orderId); 
		List<OrderSelectVO> fromCart = orderService.selectOrderDetailProductList(orderId);		
		
		httr.setAttribute("myOrder",myOrder );
		httr.setAttribute("fromCart", fromCart);
	}
	
	//주문내역보기(회원 아이디로 조회)
	@PreAuthorize("isAuthenticated() && principal.username == #userEmail")
	@GetMapping("/list")
	public void getMyOrderListAll(Model model, String userEmail) {
		System.out.println("이메일: " + userEmail);
		model.addAttribute("orderList", orderService.selectMyListService(userEmail));
		
	}
}
