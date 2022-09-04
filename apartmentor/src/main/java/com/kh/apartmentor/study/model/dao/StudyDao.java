package com.kh.apartmentor.study.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.apartmentor.common.model.vo.Reserve;

@Repository
public class StudyDao {
	
	public int reserveSeat(SqlSessionTemplate sqlSession, Reserve r) {
		return sqlSession.insert("studyMapper.reserveSeat", r);
	}
	
	public Reserve selectReserve(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("studyMapper.selectReserve",userNo);
	}

	public ArrayList<Reserve> selectList(SqlSessionTemplate sqlSession){
		return (ArrayList)sqlSession.selectList("studyMapper.selectList");
	}
	
	public ArrayList<Reserve> selectSeatNoList(SqlSessionTemplate sqlSession, int seatNo){
		return (ArrayList)sqlSession.selectList("studyMapper.selectSeatNoList", seatNo);
	}
	
	public int updateStatus(SqlSessionTemplate sqlSession, String today) {
		return sqlSession.update("studyMapper.updateStatus", today);
	}
	
	public int updateStatusByHour(SqlSessionTemplate sqlSession, int hour) {
		return sqlSession.update("studyMapper.updateStatusByHour", hour);
	}
	
	public int deleteReserve(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.update("studyMapper.deleteReserve", userNo);
	}
}
