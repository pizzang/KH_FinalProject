package com.kh.apartmentor.fee.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.apartmentor.fee.model.vo.Fee;

@Repository
public class FeeDao {
	

	public ArrayList<Fee> selectFeeList(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("feeMapper.selectFeeList", userNo);
	}



}
