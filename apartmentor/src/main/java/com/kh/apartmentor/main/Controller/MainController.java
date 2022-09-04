package com.kh.apartmentor.main.Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.apartmentor.board.model.vo.Board;
import com.kh.apartmentor.common.model.vo.Reserve;
import com.kh.apartmentor.main.model.Service.MainService;
import com.kh.apartmentor.member.model.vo.Member;
import com.kh.apartmentor.notice.model.vo.Notice;
import com.kh.apartmentor.parkingVisit.model.service.VisitCarService;
import com.kh.apartmentor.visit.model.vo.Visit;

@Controller
public class MainController {

	@Autowired
	private MainService mainService;
	
	@Autowired
	private VisitCarService visitCarService;

	public static final String SERVICE_KEY = "Cxg6AeR%2BimSFoU9%2BWZ6JAPNCCMlkuC5%2FLqSiaCg7a5w7ra6MXu%2B2sg6ijMvlcGoNTbQLkKTlMvW7LmzJ41GJIA%3D%3D";

	StringBuilder urlBuilder = new StringBuilder(
			"http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst"); /* URL */

	@RequestMapping("main.do")
	public String main(Model m, HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		
		ArrayList<Board> bList = mainService.boardList();
		ArrayList<Notice> nList = mainService.noticeList();
		m.addAttribute("bList", bList);
		m.addAttribute("nList", nList);
		
		// 달력 관련
		ArrayList<Visit> visitList = mainService.visitReserveList(userNo);
		ArrayList<Reserve> reserveList = mainService.reserveReserveList(userNo);
		ArrayList<Notice> noticeList = mainService.noticeReserveList();
		
		m.addAttribute("visitList", visitList);
		m.addAttribute("reserveList", reserveList);
		m.addAttribute("noticeList", noticeList);
		
		
		// 방문차량등록 쿠폰
		int couponUsage = visitCarService.visitCarCount(userNo);
		m.addAttribute("couponUsage", couponUsage);
		
		return "main";
	}

}
