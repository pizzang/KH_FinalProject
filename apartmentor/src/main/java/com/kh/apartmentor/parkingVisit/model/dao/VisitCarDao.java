package com.kh.apartmentor.parkingVisit.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.parking.model.vo.Parking;
import com.kh.apartmentor.parkingVisit.model.vo.ParkingVisit;

@Repository
public class VisitCarDao {

	public int enrollVisitCar(SqlSessionTemplate sqlSession, ParkingVisit p) {
		return sqlSession.insert("visitCarMapper.enrollVisitCar", p);
	}

	public int setDayVisitCar(SqlSessionTemplate sqlSession) {
		return sqlSession.update("visitCarMapper.setDayVisitCar");
	}

	public int selectVisitCar(SqlSessionTemplate sqlSession, ParkingVisit p) {
		return sqlSession.selectOne("visitCarMapper.selectVisitCar", p);
	}

	public ArrayList<Parking> selectVisitCarList(SqlSessionTemplate sqlSession, String aptNo){
		return (ArrayList)sqlSession.selectList("visitCarMapper.selectVisitCarList", aptNo);
	}
	
	
	// --------------------------- 관리자 방문예약 ----------------------------------
	
	public int adminVisitCarListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("visitCarMapper.adminVisitCarListCount");
	}
	
	public ArrayList<Parking> adminVisitCarList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("visitCarMapper.adminVisitCarList",null, rowBounds);
	}
	
	public int deleteVisitCar(SqlSessionTemplate sqlSession, ParkingVisit p){
		return sqlSession.delete("visitCarMapper.deleteVisitCar", p);
	}

	public int visitCarCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("visitCarMapper.visitCarCount", userNo);
	}
	
}
