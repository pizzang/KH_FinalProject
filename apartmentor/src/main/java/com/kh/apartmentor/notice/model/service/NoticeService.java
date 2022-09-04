package com.kh.apartmentor.notice.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.notice.model.vo.Notice;

public interface NoticeService {
	
	// 공지사항 입력
	int insertNotice(Notice n);
	
	// 공지사항 총 게시글 수 
	int selectListCount();
	
	// 공지사항 조회
	ArrayList<Notice> selectList(PageInfo pi);
	
	// 공지사항 말머리 별 게시글 수
	int selectCategoryListCount(String category);
	
	// 공지사항 말머리 별 게시글 조회
	ArrayList<Notice> selectCategoryList(String category, PageInfo pi);
	
	// 공지사항 검색 별 게시글 수
	int searchListCount(HashMap map);
	
	// 공지사항 검색 별 게시글 조회
	ArrayList<Notice> searchList(HashMap map, PageInfo pi);
	
	// 공지사항 상세 페이지
	Notice selectNotice(int noticeNo);
	
	// 공지사항 수정 입력
	int updateNotice(Notice n);
	
	// 공지사항 삭제
	int deleteNotice(int noticeNo);

}
