package com.kh.apartmentor.fee.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.apartmentor.fee.model.dao.FeeDao;
import com.kh.apartmentor.fee.model.vo.Fee;

@Service
public class FeeServiceImpl implements FeeService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private FeeDao feeDao;

	@Override
	public ArrayList<Fee> selectFeeList(int userNo) {
		return feeDao.selectFeeList(sqlSession, userNo);
	}
	
	

}
