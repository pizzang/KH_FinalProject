package com.kh.apartmentor.visit.model.service;

import java.util.ArrayList;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.member.model.vo.Member;
import com.kh.apartmentor.visit.model.vo.Visit;
import com.kh.apartmentor.visit.model.vo.VisitCategory;

public interface VisitService {

	// 예약 작성하기
	int insertVisitReserve(Visit v);
	
	// 카테고리
	ArrayList<VisitCategory> selectVisitCategory();
	
	// 예약 날짜 / 시간 가져오기
	ArrayList<Visit> selectVisitReserve(int userNo);
	
	// 예약 가능 여부 검색
	Visit checkVisitReserve(Visit v);
	
	// 총 예약 날짜 / 시간 가져오기
	ArrayList<Visit> selectVisitAllReserve();
	
	// 총 예약 조회
	int selectListCount();
	
	// 예약 리스트 조회
	ArrayList<Visit> selectList(PageInfo pi);
	
	// 카테고리 별 예약 조회
	int selectCategoryListCount(String category);
	
	// 카테고리 별 예약 리스트 조회
	ArrayList<Visit> selectCategoryList(String category, PageInfo pi);
	
	// 상태 별 예약 조회
	int selectStatusListCount(String statusCategory);
	
	// 상태 별 예약 리스트 조회
	ArrayList<Visit> selectStatusList(String statusCategory, PageInfo pi);
	
	// 예약 상세 조회
	Visit selectVisit(int visitNo);
	
	// 예약 승인
	int okReserveStatus(int visitNo);
	
	// 예약 거절
	int noReserveStatus(int visitNo);

	// 예약 취소 신청
	int cancelStatus(int visitNo);

	// 예약 취소
	int cancelReserveStatus(int vno);
	
}
