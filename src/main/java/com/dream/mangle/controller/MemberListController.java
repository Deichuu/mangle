package com.dream.mangle.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.mangle.common.paging.PagingDTO;
import com.dream.mangle.domain.AuthorityVO;
import com.dream.mangle.service.MemberListService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/admin")
public class MemberListController {

	private MemberListService memberListService;
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@GetMapping("/memberList")
	public void showMemberList(Model model) {
		model.addAttribute("list",memberListService.selectAllMemberList());
	}
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/memberList")
	public void searchMember(Model model,@ModelAttribute("paging") PagingDTO paging) {
		model.addAttribute("list", memberListService.selectMemberSearch(paging));
		model.addAttribute("paging",paging);
	
	}
	
	@PreAuthorize("hasAnyAuthority('ADMIN')")
	@PostMapping("/memberAuth")
	public String modifyAuth(Model model, AuthorityVO auth) {
		System.out.println("auth:====================================" + auth);
		model.addAttribute("auth",memberListService.updateAuth(auth));
		return "redirect:/admin/memberList";
	}
	
}
