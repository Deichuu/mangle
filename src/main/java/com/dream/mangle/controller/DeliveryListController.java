package com.dream.mangle.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.mangle.domain.DeliveryVO;
import com.dream.mangle.service.DeliveryListService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/admin")
public class DeliveryListController {

	private DeliveryListService deliveryListService;
	
	//배송목록 조회
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/deliveryList")
	public void showDeliveryList(Model model) {
		model.addAttribute("list",deliveryListService.selectAllDelivery());
	}
	
	//배송상태 변경
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/deliveryStatus")
	public String modifyDstatus(Model model, DeliveryVO delivery) {
		System.out.println("찍힘" + delivery);
		model.addAttribute("adminDelivery", deliveryListService.updateDelivery(delivery));
		return "redirect:/admin/deliveryList";
	}
	
	//송장번호 업데이트
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/deliveryInvoice")
	public String modifyInvoice(Model model, DeliveryVO deliver) {
		System.out.println("controller" + deliver);
		model.addAttribute("adminInvoice", deliveryListService.updateInvoice(deliver));
		return "redirect:/admin/deliveryList";
	}
	
	
}
