package com.kh.apartmentor.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.common.template.Pagination;
import com.kh.apartmentor.member.model.service.MemberService;
import com.kh.apartmentor.member.model.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder; 
	
	@RequestMapping("list.me")
	public ModelAndView memeberList(@RequestParam(value="cpage", defaultValue="1") int currentPage,ModelAndView mv) {
		PageInfo pi = Pagination.getPageInfo(memberService.selectListCount(), currentPage, 5, 10);
		
		ArrayList<Member> mList = memberService.memberList(pi);
		
		mv.addObject("mList",mList)
		  .addObject("pi", pi)
		  .setViewName("member/memberList");
		
		return mv;
	}
	
	@RequestMapping("search.me")
	public ModelAndView searchMember(@RequestParam(value="cpage", defaultValue="1")  int currentPage, String keyword, ModelAndView mv,String condition) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("condition", condition);
		
		
		PageInfo pi = Pagination.getPageInfo(memberService.selectSearchCount(map), currentPage, 5, 10);
		
		ArrayList<Member> sList = memberService.memberSearchList(map, pi);
		
		mv.addObject("sList", sList)
		  .addObject("condition",condition)
		  .addObject("pi", pi)
		  .addObject("keyword", keyword)
		  .setViewName("member/memberList");
		return mv;
	}
	
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m,HttpSession session,ModelAndView mv) {
		
		Member loginUser = memberService.loginMember(m);
		
		if(loginUser != null && bCryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			
			if(loginUser.getStatus().equals("W")) {
				
				session.setAttribute("alertMsg1", "승인되지 않은 회원입니다.");
				mv.setViewName("redirect:/");
				
			} else if(loginUser.getStatus().equals("N")){
				
				session.setAttribute("alertMsg1", "탈퇴(정지)된 회원입니다");
				mv.setViewName("redirect:/");
				
			}else {
			
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:main.do");
			}
		} else {
			session.setAttribute("noLogin", "noLogin");
			mv.setViewName("redirect:/");
		}
		
		return mv;
	}
	
	@RequestMapping("approval.me")
	public ModelAndView approvalMember(String userNo, ModelAndView mv) {
		
		int result = memberService.approvalMember(userNo);
		
		if(result > 0) {
			mv.addObject("alertMsg2",userNo + " 번 회원이 승인 되었습니다.");
		} else {
			mv.addObject("alertMsg1",userNo + " 번 회원이 승인에 실패 하였습니다.");
		}
		mv.setViewName("redirect:list.me");
		
		return mv;
	}
	@RequestMapping("suspension.me")
	public ModelAndView suspensionMember(String userNo, ModelAndView mv) {
		
		int result = memberService.suspensionMember(userNo);
		
		if(result > 0) {
			mv.addObject("alertMsg2",userNo + " 번 회원이 정지 되었습니다.");
		} else {
			mv.addObject("alertMsg1",userNo + " 번 회원 정지에 실패 하였습니다.");
		}
		mv.setViewName("redirect:list.me");
		
		return mv;
	}
	
	@RequestMapping("insert.me")
	public String insertMember(Member m,ModelAndView mv, HttpSession session, String aptNo1, String aptNo2) {
		String aptNo = aptNo1 + "동" + aptNo2 + "호";
		m.setAptNo(aptNo);
		
		String encPwd = bCryptPasswordEncoder.encode(m.getUserPwd());
		
		
		m.setUserPwd(encPwd);
		
		int result = memberService.insertMember(m);
		
		if(result > 0) {
			session.setAttribute("alertMsg2", "성공적으로 회원가입이 되었습니다.");
			return "redirect:/";
		}else { 
			mv.addObject("alertMsg1", "다시 확인해주세요.");
			return "NO";
		}
	}
	@ResponseBody
	@RequestMapping(value = "selectId.me", produces="application/json; charset=UTF-8")
	public String findId(String name,String birthday,String email, String aptNo1, String aptNo2) {

		Member m = new Member();
		String aptNo = aptNo1 + "동" + aptNo2 + "호";
		m.setUserName(name);
		m.setEmail(email);
		m.setBirthday(birthday);
		m.setAptNo(aptNo);
		
		Member userId = memberService.selectId(m);
		return new Gson().toJson(userId);
		
	}
	@ResponseBody
	@RequestMapping(value = "findPwd.me", produces="application/json; charset=UTF-8")
	public String findPwd(String id, String name,String birthday, String aptNo1, String aptNo2,HttpSession session) {
		String aptNo = aptNo1 + "동" + aptNo2 + "호";
		Member m = new Member();
		m.setUserId(id);
		m.setUserName(name);
		m.setBirthday(birthday);
		m.setAptNo(aptNo);
		
		Member userPwd = memberService.findPwd(m);
		userPwd.setUserId(id);
		
		return new Gson().toJson(userPwd);
		
	}
	@RequestMapping(value = "update.pw")
	public String updatePw(String newPwd, String checkPwd, String pwdId, HttpSession session) {
		
		
		if(newPwd.equals(checkPwd)) {
			newPwd = checkPwd;
			
			String encPwd = bCryptPasswordEncoder.encode(newPwd);
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("encPwd", encPwd);
			map.put("pwdId", pwdId);
			
			int result = memberService.updatePwd(map);
			
			
			if(result > 0) {
				session.setAttribute("alertMsg2", "비밀번호 변경완료.");
			} else {
				session.setAttribute("alertMsg1", "비밀번호 변경실패.");
			}
		} else {
			session.setAttribute("alertMsg1", "비밀번호가 동일하지 않습니다.");
		}
		return "redirect:/";
	}
	@ResponseBody
	@RequestMapping(value = "checkId.me" , produces="application/json; charset=UTF-8")
	public int checkId1(String userId) {
		int count = memberService.checkId1(userId);
		if(count > 0) {
			return 0 ;
		} else {
			return 1;
		}
		
	}
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	@RequestMapping("update.me")
	public String updateMember(Member m, HttpSession session) {
		
		String encPwd = bCryptPasswordEncoder.encode(m.getUserPwd());
		m.setUserPwd(encPwd);
		
		int result = memberService.updateMember(m);
		
		if(result > 0) {
			session.setAttribute("alertMsg2", "회원정보 변경성공!");
		} else {
			session.setAttribute("alertMsg1", "회원정보 변경실패!");
		}
		return "redirect:main.do";
	}
	
}
