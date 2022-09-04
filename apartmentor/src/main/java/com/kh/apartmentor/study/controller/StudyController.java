package com.kh.apartmentor.study.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.apartmentor.common.model.vo.Reserve;
import com.kh.apartmentor.study.model.service.StudyService;

@Controller
public class StudyController {
	
	@Autowired
	private StudyService studyService;
	
	@RequestMapping("seatView.st") 
	public String study() { 
		return "study/seatView"; 
	}
	
	@ResponseBody
	@RequestMapping(value="seatView.st", produces="application/json; charset=UTF-8")
	public String ajaxSelectList() {
		//ArrayList<Reserve> list = studyService.selectList();
		return new Gson().toJson(studyService.selectList());
	}
	
	@ResponseBody
	@RequestMapping(value="reservedInfo.st", produces="application/json; charset=UTF-8")
	public String ajaxReservedInfo(int userNo) {
		return new Gson().toJson(studyService.selectReserve(userNo));
	}
	
	@ResponseBody
	@RequestMapping(value="timeTable.st", produces="application/json; charset=UTF-8")
	public String ajaxTimeTable(int seatNo) {
		//ArrayList<Reserve> list = studyService.selectSeatNoList(seatNo);
		return new Gson().toJson(studyService.selectSeatNoList(seatNo));
	}
	
	@ResponseBody
	@RequestMapping(value="reserveSeat.st", produces="application/json; charset=UTF-8")
	public String ajaxReserveSeat(String startTime, String endTime, int seatNo, int userNo) {
		
		// 전달 받은 값
		Reserve r = new Reserve();
		r.setStartDate(startTime);
		r.setEndDate(endTime);
		r.setFacility("st"); 
		r.setSeatNo(seatNo);
		r.setUserNo(userNo);
		r.setStatus("Y");
		
		// 예약정보 리스트
		ArrayList<Reserve> seatList = studyService.selectList();
		
		int result = 0;
		int reservedUserNo = 0;
		Reserve rsv = null;
		
		// 리스트에 유저넘버 reservedUserNo에 담기
		for(int i=0; i<seatList.size(); i++) {
			if(seatList.get(i).getUserNo() == r.getUserNo()) {
				reservedUserNo = seatList.get(i).getUserNo();
			}else {
				reservedUserNo = 0;
			}
		}

		if(reservedUserNo == 0) {
			
			result = studyService.reserveSeat(r);
			
			if(result > 0) {
				rsv = studyService.selectReserve(userNo);
				//System.out.println(rsv);
			}else {
				rsv = null;
			}
			
		}else {
			rsv = null;
		}
		
		return new Gson().toJson(rsv);
	}
	
	@ResponseBody
	@RequestMapping("updateStatus.st")
	public ModelAndView updateReserve(ModelAndView mv, String today, int hour) {
		
		int result = studyService.updateStatus(today);
		//System.out.println("독서실 전 날 이용자 수 : " + result);
		int result2 = studyService.updateStatusByHour(hour);
		System.out.println(result2);
		mv.addObject("updateStatus", studyService.updateStatus(today))
		  .setViewName("study/seatView");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("deleteReserve.st")
	public int deleteReserve(int userNo) {
		
		int result = studyService.deleteReserve(userNo);
		
		return result;
	}

	
	
	
	
	
	
	
	
	
	
	

}
