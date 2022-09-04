package com.kh.apartmentor.study.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.apartmentor.common.model.vo.Reserve;
import com.kh.apartmentor.study.model.dao.StudyDao;

@Service
public class StudyServiceImpl implements StudyService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private StudyDao studyDao;

	@Override
	public int reserveSeat(Reserve r) {
		return studyDao.reserveSeat(sqlSession, r);
	}

	@Override
	public Reserve selectReserve(int userNo) {
		return studyDao.selectReserve(sqlSession, userNo);
	}

	@Override
	public ArrayList<Reserve> selectList() {
		return studyDao.selectList(sqlSession);
	}
	
	@Override
	public ArrayList<Reserve> selectSeatNoList(int seatNo) {
		return studyDao.selectSeatNoList(sqlSession, seatNo);
	}

	@Override
	public int updateStatus(String today) {
		return studyDao.updateStatus(sqlSession, today);
	}
	
	@Override
	public int updateStatusByHour(int hour) {
		return studyDao.updateStatusByHour(sqlSession, hour);
	}

	@Override
	public int deleteReserve(int userNo) {
		return studyDao.deleteReserve(sqlSession, userNo);
	}

	
}
