package com.kh.apartmentor.main.model.Service;

import java.util.ArrayList;

import com.kh.apartmentor.board.model.vo.Board;
import com.kh.apartmentor.common.model.vo.Reserve;
import com.kh.apartmentor.notice.model.vo.Notice;
import com.kh.apartmentor.visit.model.vo.Visit;

public interface MainService {
	
	// 자유게시판
	ArrayList<Board> boardList();
	
	// 공지
	ArrayList<Notice> noticeList();

	// 일정 관련
	ArrayList<Visit> visitReserveList(int userNo);
	ArrayList<Reserve> reserveReserveList(int userNo);
	ArrayList<Notice> noticeReserveList();

	

}
