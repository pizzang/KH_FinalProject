package com.kh.apartmentor.chat.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.apartmentor.chat.model.service.ChatService;
import com.kh.apartmentor.chat.model.vo.Chat;
import com.kh.apartmentor.member.model.vo.Member;


@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	// 주민채팅방 페이지로 포워딩
	@RequestMapping("chatForm.ch")
	public String chatForm(Model model, HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
			// 온라인구분을 위한 회원 전체 조회 
			ArrayList<Member> MemberList = chatService.selectMemberList();
			session.setAttribute("MemberList", MemberList);
			
			// 로그인한 유저가 관리실일 경우 관리실 전용 채팅 페이지로 포워딩
		if(loginUser.getUserNo() == 1) {
			return "chat/guardExcludeChatView";
		}
		// 주민채팅리스트 조회(chatCode=1)
		ArrayList<Chat> chatList = chatService.selectChatList();
		model.addAttribute("chatList", chatList);
		
		// 날짜별 구분을 위해 중복값없이 날짜만 조회
		ArrayList<Chat> sendDateList = chatService.selectSendDateList();
		model.addAttribute("sendDateList", sendDateList);
		return "chat/chatView";
	}
	
	// 그룹채팅내역 DB저장
	@ResponseBody
	@RequestMapping("insertChat.ch")
	public String insertChat(Chat c) {
		return chatService.insertChat(c) > 0 ? "success" : "fail";
	}
	
	// 관리실채팅방 페이지로 포워딩
	@RequestMapping("guardChatForm.ch")
	public String guardChatForm(Model model) {
		
		return "chat/guardChatView";
	}
	
	// 관리실 채팅 리스트 조회 
	@ResponseBody
	@RequestMapping(value="selectGuardChatList.ch", produces="application/json; charset=UTF-8")
	public String selectGuardChatList(int userNo) {
		ArrayList<Chat> list = chatService.selectGuardChatList(userNo);
		return new Gson().toJson(list);
	}
	
	// 관리실 채팅방 회원 채팅 작성 
	@ResponseBody
	@RequestMapping("guardChatInsert.ch")
	public String guardChatInsert(Chat c) {
		return chatService.guardChatInsert(c) > 0 ? "success" : "fail";
	}
	
	// 관리실채팅방에서 회원 클릭시 회원과의 채팅 내역 조회
	@RequestMapping("guardExcludeChatList.ch")
	public String guardExcludeChatList(int userNo, Model model) {
		ArrayList<Chat> gList = chatService.selectGuardChatList(userNo);
		model.addAttribute("gList", gList);
		return "chat/guardExcludeChatView";
	}
	
	
	
	
}
