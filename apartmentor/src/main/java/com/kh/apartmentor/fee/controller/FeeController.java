package com.kh.apartmentor.fee.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.apartmentor.fee.model.service.FeeService;
import com.kh.apartmentor.fee.model.vo.Fee;
import com.kh.apartmentor.member.model.service.MemberService;

@Controller
public class FeeController {

	@Autowired
	private FeeService feeService;
	
	@RequestMapping("feeView.fe") 
	public String fee() { 
		return "fee/feeView"; 
	}
	
	@ResponseBody
	@RequestMapping(value="feeView.fe", produces="application/json; charset=UTF-8")
	public String ajaxSelectFeeList(int userNo) {
		
		ArrayList<Fee> f = feeService.selectFeeList(userNo);
		System.out.println(f);
		
		return new Gson().toJson(feeService.selectFeeList(userNo));
	}
}
