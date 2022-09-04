package com.kh.apartmentor.parking.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.common.template.Pagination;
import com.kh.apartmentor.member.model.vo.Member;
import com.kh.apartmentor.parking.model.service.RegoCarService;
import com.kh.apartmentor.parking.model.vo.Parking;

@Controller
public class RegoCarController {

	@Autowired
	private RegoCarService regoCarService;
	
	//------------- 차량등록  -------------------------
	
	// 차량 등록 페이지 띄우기 
	@RequestMapping("regoCar.rg")
	public String regoCarView() {
		return "regoCar/regoCar";
	}
	
	// 주차 등록 
	@ResponseBody
	@RequestMapping(value="insertRegoCar.rg", produces="application/json; charset=UTF-8")
	public String insertRegoCar(Parking p) {
		return new Gson().toJson(regoCarService.insertRegoCar(p));
	}
	
	// 주차 리스트 
	@ResponseBody
	@RequestMapping(value="selectRegoCarList.rg", produces="application/json; charset=UTF-8")
	public String selectRegoCarList(String aptNo) {
		return new Gson().toJson(regoCarService.selectRegoCarList(aptNo));
	}
	
	// 주차 등록 삭제 (관리자 페이지에서도 사용)
	@ResponseBody
	@RequestMapping(value="deleteRegoCar.rg", produces="application/json; charset=UTF-8")
	public String deleteRegoCar(String carNo) {
		return new Gson().toJson(regoCarService.deleteRegoCar(carNo));
	}
	
	//-------------------- 관리자 차량등록 ---------------------------------------------------
	
	// 관리자 차량 등록 페이지 띄우기 
	@RequestMapping("adminRegoCar.rg")
	public ModelAndView adminRegoCarList(@RequestParam(value="cpage", defaultValue = "1") int currentPage, String category, ModelAndView mv) {
		
		// 페이징 처리를 위한 VO담기
		PageInfo pi = Pagination.getPageInfo(regoCarService.adminRegoCarListCount(category), currentPage, 10, 5);
		
		//ArrayList<Parking> list = regoCarService.adminRegoCarList(category, pi);

		mv.addObject("pi", pi)
	      .addObject("category", category)
	      .addObject("list", regoCarService.adminRegoCarList(category, pi))
	      .setViewName("regoCar/adminRegoCar");
		
	    return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="appRegoCar.rg", produces="application/json; charset=UTF-8")
	public String appRegoCar(String carNo) {
		return new Gson().toJson(regoCarService.appRegoCar(carNo));
	}
	
	
	
	
	
	
	
	
	
}
