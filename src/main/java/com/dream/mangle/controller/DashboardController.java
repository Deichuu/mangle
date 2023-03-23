package com.dream.mangle.controller;

import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.mangle.service.ArtistStaticService;
import com.dream.mangle.service.DashboardService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin")
@AllArgsConstructor
public class DashboardController {
	
	private DashboardService service;
	private ArtistStaticService artistService;
	
	@GetMapping("/dashboard")
	public void showDashboard(Model model) {
		model.addAttribute("memberCnt", service.selectMemberCnt());
		model.addAttribute("newMember", service.selectNewMem());
		model.addAttribute("totalSales", service.selectTotalSales());
		model.addAttribute("newMtoM", service.selectNewMtoM());
		model.addAttribute("newOrder", service.selectNewOrder());
		model.addAttribute("deliStatus", service.selectDstatus());
		model.addAttribute("lowStock", service.selectLowStock());
		model.addAttribute("perCate", service.selectPerCate());
		model.addAttribute("salePerDay", service.selectSalePerDay());
		model.addAttribute("salePerMonth", service.selectSalePerMonth());
		model.addAttribute("salePerYear", service.selectSalePerYear());
		model.addAttribute("bestProd", service.selectBestProduct());
	}
	
	@PreAuthorize("hasAnyAuthority('ILLUSTRATOR')")
	@GetMapping("/artist")
	public String showArtist(String userEmail, Model model) {
		model.addAttribute("productList", artistService.getproductList(userEmail)); //제품별
		model.addAttribute("todaySales", artistService.getTodaySales(userEmail));   //오늘 팔린것
		model.addAttribute("todayCount", artistService.getTodayCount(userEmail));   // 오늘 팔린거 계산
		model.addAttribute("totalCategory", artistService.getTotalCategory(userEmail)); //카테고리별
		model.addAttribute("perDays", artistService.getPerDays(userEmail));             //일일통계
		model.addAttribute("perMonths", artistService.getPerMonths(userEmail));         //한달통계
		model.addAttribute("perYears", artistService.getPerYears(userEmail));           //일년통계
		return "admin/artist_static";
	}
	
	@GetMapping("/nodeJson")
	public ResponseEntity<JSONObject> nodeJsonStr(){
		JSONObject jsonObject = new JSONObject();
		jsonObject.append("memberCnt", service.selectMemberCnt());
		jsonObject.append("memberCnt", service.selectMemberCnt());
		jsonObject.append("newMember", service.selectNewMem());
		jsonObject.append("totalSales", service.selectTotalSales());
		jsonObject.append("new1on1", service.selectNewMtoM());
		jsonObject.append("newOrder", service.selectNewOrder());
		jsonObject.append("perCate", service.selectPerCate());
		jsonObject.append("salePerDay", service.selectSalePerDay());
		jsonObject.append("salePerMonth", service.selectSalePerMonth());
		jsonObject.append("salePerYear", service.selectSalePerYear());
		jsonObject.append("bestProd", service.selectBestProduct());
		return new ResponseEntity<JSONObject> (jsonObject, HttpStatus.OK);
	}
	
}
