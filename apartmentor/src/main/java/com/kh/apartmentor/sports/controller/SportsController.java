package com.kh.apartmentor.sports.controller;


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
import com.kh.apartmentor.common.model.vo.Reserve;
import com.kh.apartmentor.common.template.Pagination;
import com.kh.apartmentor.member.model.vo.Member;
import com.kh.apartmentor.sports.service.SportsService;

@Controller
public class SportsController {
	
	@Autowired
	private SportsService sportsService;

	//------------------------- golf ------------------------------------------
	// 골프 예약하는 페이지 띄우기
	@RequestMapping("golf.sp")
	public String Golf() {
		return "sports/golf";
	}
	
	// 예약하기 버튼을 누르기전에 같은시간, 같은날짜에 예약이 있으면 예약 안되구 없으면 예약하게 하는 코드
	@ResponseBody
	@RequestMapping("reserveGolfSeat.sp")
	public String insertGolfSeat(Reserve r) {
		//System.out.println(r);
		//System.out.println(r.getStartDay());
		
		ArrayList<Reserve> list = sportsService.searchTimeAndDate(r);
		if(!list.isEmpty()) {
			return "fail";
		} else {
			return sportsService.insertGolfSeat(r) > 0 ? "success" : "fail";
		}
	}
	
	// 골프 검색하기 눌렀을때 예약할 수 있는지 없는지 버튼으로 확인 하는 코드
	@ResponseBody
	@RequestMapping(value="golfSeatList.sp", produces="application/json; charset=UTF-8")
	public String selectGolfSeatList(Reserve r) {
		return new Gson().toJson(sportsService.selectGolfSeatList(r));
	}
	
	//------------------------------ miniGym -----------------------------------
	// 미니짐 화면 띄우기
	@RequestMapping("miniGym.sp")
	public String MiniGym() {
		return "sports/miniGym";
	}
	
	// 미니짐 시간(예약 완료, 예약가능) 띄워주는 코드
	@ResponseBody
	@RequestMapping(value="miniGymTimeList.sp", produces="application/json; charset=UTF-8")
	public String selectMiniGymTimeList(Reserve r) {
		return new Gson().toJson(sportsService.selectMiniGymTimeList(r));
	}
	
	// 예약하기 버튼을 누르기전에 같은시간, 같은날짜에 예약이 있으면 예약 안되구 없으면 예약하게 하는 코드
	@ResponseBody
	@RequestMapping("reserveMiniGym.sp")
	public String insertMiniGym(Reserve r) {
		//System.out.println(r);
		ArrayList<Reserve> list = sportsService.searchDate(r);
		if(!list.isEmpty()) {
			return "fail";
		} else {
			return sportsService.insertMiniGym(r) > 0 ? "success" : "fail";
		}
	}
	
	
	//---------------------------------------- 이용내역 -------------------------------------------
	// 카테고리 리스트 띄우기
	@RequestMapping("sportsOptionView.sp")
	public ModelAndView selectOptionList(@RequestParam(value="cpage", defaultValue = "1") int currentPage, HttpServletRequest request, String category, ModelAndView mv) {
		
		HttpSession session = request.getSession();
		String userNo = Integer.toString(((Member)session.getAttribute("loginUser")).getUserNo());
		// HashMap으로 두개의 변수를 받아온다.
		HashMap<String, String> map = new HashMap();
		map.put("category", category);
		map.put("userNo", userNo);
		
		// 페이징 처리를 위한 VO담기
		PageInfo pi = Pagination.getPageInfo(sportsService.selectOptionListCount(map), currentPage, 10, 5);
		
		mv.addObject("pi", pi)
		  .addObject("category", category)
		  .addObject("list", sportsService.selectOptionList(map, pi))
		  .setViewName("sports/sportsListView");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("deleteReserveSports.sp")
	public String deleteReserveSports(int reserveNo) {
		//System.out.println(reserveNo);
		return sportsService.deleteReserveSports(reserveNo) > 0 ? "success" : "fail";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
