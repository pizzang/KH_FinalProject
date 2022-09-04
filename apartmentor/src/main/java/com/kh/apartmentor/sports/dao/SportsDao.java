package com.kh.apartmentor.sports.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.common.model.vo.Reserve;

@Repository
public class SportsDao {

	//-------------------------- golf ---------------------------------------------------------
	
	public ArrayList<Reserve> selectGolfSeatList(SqlSessionTemplate sqlSession, Reserve r) {
		return (ArrayList)sqlSession.selectList("sportsMapper.selectGolfSeatList", r);
	}
	
	public ArrayList<Reserve> searchTimeAndDate(SqlSessionTemplate sqlSession, Reserve r) {
		return (ArrayList)sqlSession.selectList("sportsMapper.searchTimeAndDate", r);
	}

	public int insertGolfSeat(SqlSessionTemplate sqlSession, Reserve r) {
		return sqlSession.insert("sportsMapper.insertGolfSeat", r);
	}
	
	
	//--------------------------- miniGym ----------------------------------------------------
	
	public ArrayList<Reserve> selectMiniGymTimeList(SqlSessionTemplate sqlSession, Reserve r){
		return (ArrayList)sqlSession.selectList("sportsMapper.selectMiniGymTimeList", r);
	}
	
	public ArrayList<Reserve> searchDate(SqlSessionTemplate sqlSession, Reserve r) {
		return (ArrayList)sqlSession.selectList("sportsMapper.searchDate", r);
	}
	
	public int insertMiniGym(SqlSessionTemplate sqlSession, Reserve r) {
		return sqlSession.insert("sportsMapper.insertMiniGym", r);
	}
	
	
	// --------------------------- 이용내역 ----------------------------------------------------
	 
	public int selectOptionListCount(SqlSessionTemplate sqlSession, HashMap<String,String> map) {
		return sqlSession.selectOne("sportsMapper.selectOptionListCount", map);
	}
	
	public ArrayList<Reserve> selectOptionList(SqlSessionTemplate sqlSession, HashMap<String, String> map, PageInfo pi){
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("sportsMapper.selectOptionList", map, rowBounds);
	}
	
	public int deleteReserveSports(SqlSessionTemplate sqlSession, int reserveNo) {
		return sqlSession.delete("sportsMapper.deleteReserveSports", reserveNo);
	}
	
	
	
	
	
}
