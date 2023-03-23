package com.dream.mangle.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dream.mangle.domain.DeliveryVO;
import com.dream.mangle.service.DeliveryService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/delivery")
@AllArgsConstructor
public class DeliveryController {
	
	private DeliveryService deliveryService;
	
	@PreAuthorize("isAuthenticated() && principal.username == #userEmail")
	@GetMapping("/list")
	public void showDeliveList(Model model, String userEmail) {
		
		model.addAttribute("delivlist", deliveryService.selectDeliveryList(userEmail));
		
	}
	
	@PreAuthorize("isAuthenticated() && principal.username == #userEmail")
	@GetMapping("/detail")
	public void showDetailList(Model model, String orderId, String userEmail) {
		
		model.addAttribute("dl", deliveryService.selectDeliveryDetail(orderId));
		model.addAttribute("total",deliveryService.selectTotal(orderId));
		
	}
	
	@PostMapping("/status")
	@ResponseBody
	public String statusUp(DeliveryVO deliveryVO) {
		if(deliveryService.updateDstatus(deliveryVO) == 1) {
			return "y";
		}else {
			return "n";
		}
	}
	
}

