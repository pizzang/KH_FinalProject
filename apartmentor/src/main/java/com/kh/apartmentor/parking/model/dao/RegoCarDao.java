package com.kh.apartmentor.parking.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.parking.model.vo.Parking;

@Repository
public class RegoCarDao {

	public int insertRegoCar(SqlSessionTemplate sqlSession, Parking p){
		return sqlSession.insert("regoCarMapper.insertRegoCar", p);
	}
	
	public ArrayList<Parking> selectRegoCarList(SqlSessionTemplate sqlSession, String aptNo){
		return (ArrayList)sqlSession.selectList("regoCarMapper.selectRegoCarList", aptNo);
	}
	
	public int deleteRegoCar(SqlSessionTemplate sqlSession, String carNo){
		return sqlSession.delete("regoCarMapper.deleteRegoCar", carNo);
	}
	
	// ----------------------관리자 -----------------------------------------------
	
	public int adminRegoCarListCount(SqlSessionTemplate sqlSession, String category) {
		return sqlSession.selectOne("regoCarMapper.adminRegoCarListCount", category);
	}
	
	public ArrayList<Parking> adminRegoCarList(SqlSessionTemplate sqlSession, String category, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("regoCarMapper.adminRegoCarList", category, rowBounds);
	}
	
	public int appRegoCar(SqlSessionTemplate sqlSession, String carNo){
		return sqlSession.update("regoCarMapper.appRegoCar", carNo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
