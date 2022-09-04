package com.kh.apartmentor.chat.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.apartmentor.chat.model.dao.ChatDao;
import com.kh.apartmentor.chat.model.vo.Chat;
import com.kh.apartmentor.member.model.vo.Member;

@Service
public class ChatService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ChatDao chatDao;

	public ArrayList<Chat> selectChatList() {
		return chatDao.selectChatList(sqlSession);
	}

	public int insertChat(Chat c) {
		return chatDao.insertChat(sqlSession, c);
	}

	public ArrayList<Member> selectMemberList() {
		return chatDao.selectMemberList(sqlSession);
	}

	public ArrayList<Chat> selectSendDateList() {
		return chatDao.selectSendDateList(sqlSession);
	}

	public ArrayList<Chat> selectGuardChatList(int userNo) {
		return chatDao.selectGuardChatList(sqlSession, userNo);
	}

	public int guardChatInsert(Chat c) {
		return chatDao.guardChatInsert(sqlSession, c);
	}

}
