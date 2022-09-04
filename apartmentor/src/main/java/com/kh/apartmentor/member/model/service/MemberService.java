package com.kh.apartmentor.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.apartmentor.board.model.vo.Board;
import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.member.model.vo.Member;

public interface MemberService {
	
	// 로그인
	Member loginMember(Member m);
	
	// 회원가입
	int insertMember(Member m);
	
	// 아이디 찾기
	Member selectId(Member m);
	// 비밀번호 확인작업
	Member findPwd(Member m);
	// 비밀번호 변경
	int updatePwd(HashMap<String, String> map);

	// 아이디 중복체크
	int checkId1(String userId);

	// 회원정보변경
	int updateMember(Member m);
	// 회원조회
	int selectListCount();
	
	ArrayList<Member> memberList(PageInfo pi);
	
	// 검색조회
	int selectSearchCount(HashMap<String, String> map);

	ArrayList<Member> memberSearchList(HashMap<String, String> map, PageInfo pi);

	// 회원 승인
	int approvalMember(String userNo);
	// 회원 정지
	int suspensionMember(String userNo);

}
