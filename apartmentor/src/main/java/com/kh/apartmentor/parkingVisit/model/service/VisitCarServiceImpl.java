package com.kh.apartmentor.parkingVisit.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.parking.model.vo.Parking;
import com.kh.apartmentor.parkingVisit.model.dao.VisitCarDao;
import com.kh.apartmentor.parkingVisit.model.vo.ParkingVisit;

@Service
public class VisitCarServiceImpl implements VisitCarService {
	
	@Autowired
	private VisitCarDao visitCarDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	@Override
	public int enrollVisitCar(ParkingVisit p) {
		return visitCarDao.enrollVisitCar(sqlSession, p);
	}

	@Override
	public int setDayVisitCar() {
		return visitCarDao.setDayVisitCar(sqlSession);
	}

	@Override
	public int selectVisitCar(ParkingVisit p) {
		return visitCarDao.selectVisitCar(sqlSession, p);
	}

	@Override
	public ArrayList<Parking> selectVisitCarList(String aptNo){
		 return visitCarDao.selectVisitCarList(sqlSession, aptNo);
	}
	
	
	//--------------------------- 관리자 방문예약 ------------------------------------
	
	@Override
	public int adminVisitCarListCount() {
		return visitCarDao.adminVisitCarListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Parking> adminVisitCarList(PageInfo pi){
		return visitCarDao.adminVisitCarList(sqlSession, pi);
	}
	
	@Override
	public int deleteVisitCar(ParkingVisit p){
		return visitCarDao.deleteVisitCar(sqlSession, p);
	}

	@Override
	public int visitCarCount(int userNo) {
		return visitCarDao.visitCarCount(sqlSession, userNo);
	}
	
	
	
	
}