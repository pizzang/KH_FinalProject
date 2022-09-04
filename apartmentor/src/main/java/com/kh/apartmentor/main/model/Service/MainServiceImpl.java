package com.kh.apartmentor.main.model.Service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.apartmentor.board.model.vo.Board;
import com.kh.apartmentor.common.model.vo.Reserve;
import com.kh.apartmentor.main.model.dao.MainDao;
import com.kh.apartmentor.notice.model.vo.Notice;
import com.kh.apartmentor.visit.model.vo.Visit;

@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MainDao mainDao;
	
	@Override
	public ArrayList<Board> boardList() {
		return mainDao.boardList(sqlSession);
	}
	@Override
	public ArrayList<Notice> noticeList() {
		return mainDao.noticeList(sqlSession);
	}
	
	// 일정
	@Override
	public ArrayList<Visit> visitReserveList(int userNo) {
		return mainDao.visitReserveList(sqlSession, userNo);
	}
	@Override
	public ArrayList<Reserve> reserveReserveList(int userNo) {
		return mainDao.reserveReserveList(sqlSession, userNo);
	}
	@Override
	public ArrayList<Notice> noticeReserveList() {
		return mainDao.noticeReserveList(sqlSession);
	}
	

}
