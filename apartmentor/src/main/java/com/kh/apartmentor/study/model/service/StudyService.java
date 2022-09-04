package com.kh.apartmentor.study.model.service;

import java.util.ArrayList;

import com.kh.apartmentor.common.model.vo.Reserve;

public interface StudyService {
	
	
	//좌석 전체 조회 ~ 지금 하는 거
	ArrayList<Reserve> selectList();
	
	//타임테이블: 좌석 번호로 
	ArrayList<Reserve> selectSeatNoList(int seatNo);
	
	//좌석 예약
	int reserveSeat(Reserve r);
	
	//예약 조회 userNo
	Reserve selectReserve(int userNo);
	
	//상태 컬럼 수정
	int updateStatus(String today);
	
	int updateStatusByHour(int hour);
	
	//예약 취소
	int deleteReserve(int userNo);
	


	
}
