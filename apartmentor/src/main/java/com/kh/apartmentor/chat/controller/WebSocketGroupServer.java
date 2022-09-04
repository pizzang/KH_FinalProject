package com.kh.apartmentor.chat.controller;

import java.util.ArrayList;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.json.simple.JSONObject;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.kh.apartmentor.member.model.vo.Member;

/*
 * 접속한 사용자를 기억해두고 모두에 대한 처리를 수행하는 서버
 * 
 */

public class WebSocketGroupServer extends TextWebSocketHandler {
	
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<WebSocketSession>();
	private ArrayList<String> connUsers = new ArrayList<String>();
	// webSocket 연결 성공 시 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.add(session);
		Member loginUser = (Member)session.getAttributes().get("loginUser");
		connUsers.add(loginUser.getUserName());
		System.out.println("사용자 접속! : 현재 : " + users.size() + "명");
		
	}
	
	// 메시지 
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		// 인터셉터를 통해 HttpSession의 정보를 WebSocketSession에 담아왔기 때문에 접근해 사용 가능.
		Member loginUser = (Member)session.getAttributes().get("loginUser");
		
		TextMessage newMessage = new TextMessage(loginUser.getUserName() + "/" + message.getPayload());
		
		for(WebSocketSession ws : users) {
			if(!(message.getPayload()).equals("")) {
				// 사용자가 채팅 입력시 메세지 보내기
				ws.sendMessage(newMessage);
			} else {
				// 사용자가 접속 또는 종료할 경우 현재 온라인인 유저의 리스트 보내기
				ws.sendMessage(new TextMessage(connUsers+ "/" + message.getPayload()));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session);
		Member loginUser = (Member)session.getAttributes().get("loginUser");
		// 사용자가 접속 종료 시 접속한 유저의 리스트에서 지우고 갱신된 온라인 유저의 리스트를 다시 보내기 위해 handleTextMessage에 빈 문자열 보내기
		connUsers.remove(loginUser.getUserName());
		handleTextMessage(session, new TextMessage(""));
		System.out.println("사용자 종료! 현재 : " + users.size() + "명");
		
	}
	
}
