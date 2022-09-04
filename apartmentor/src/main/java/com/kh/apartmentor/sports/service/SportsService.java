package com.kh.apartmentor.sports.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.common.model.vo.Reserve;
import com.kh.apartmentor.sports.dao.SportsDao;

@Service
public class SportsService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private SportsDao sportsDao;
	
	
	// ----------------- golf ---------------------------
	
	public ArrayList<Reserve> selectGolfSeatList(Reserve r) {
		return sportsDao.selectGolfSeatList(sqlSession, r);
	}
	
	public ArrayList<Reserve> searchTimeAndDate(Reserve r) {
		return sportsDao.searchTimeAndDate(sqlSession, r);
	}
	
	public int insertGolfSeat(Reserve r) {
		return sportsDao.insertGolfSeat(sqlSession, r);
	}
	
	
	// -------------- miniGym ----------------------------
	
	public ArrayList<Reserve> selectMiniGymTimeList(Reserve r){
		return sportsDao.selectMiniGymTimeList(sqlSession, r);
	}
	
	public ArrayList<Reserve> searchDate(Reserve r) {
		return sportsDao.searchDate(sqlSession, r);
	}
	
	public int insertMiniGym(Reserve r) {
		return sportsDao.insertMiniGym(sqlSession, r);
	}
	
	
	//-------------------- 이용내역 ----------------------------
	
	public int selectOptionListCount(HashMap<String,String> map) {
		return sportsDao.selectOptionListCount(sqlSession, map);
	}
	
	public ArrayList<Reserve> selectOptionList(HashMap<String,String> map, PageInfo pi){
		return sportsDao.selectOptionList(sqlSession, map, pi);
	}
	
	public int deleteReserveSports(int reserveNo) {
		return sportsDao.deleteReserveSports(sqlSession, reserveNo);
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
