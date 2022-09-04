package com.kh.apartmentor.visit.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.visit.model.dao.VisitDao;
import com.kh.apartmentor.visit.model.vo.Visit;
import com.kh.apartmentor.visit.model.vo.VisitCategory;

@Service
public class VisitServiceImpl implements VisitService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private VisitDao visitDao;

	@Override
	public int insertVisitReserve(Visit v) {
		return visitDao.insertVisitReserve(sqlSession, v);
	}

	@Override
	public ArrayList<Visit> selectVisitReserve(int userNo) {
		return visitDao.selectVisitReserve(sqlSession, userNo);
	}

	@Override
	public ArrayList<VisitCategory> selectVisitCategory() {
		return visitDao.selectVisitCategory(sqlSession);
	}

	@Override
	public Visit checkVisitReserve(Visit v) {
		return visitDao.checkVisitReserve(sqlSession, v);
	}

	@Override
	public ArrayList<Visit> selectVisitAllReserve() {
		return visitDao.selectVisitAllReserve(sqlSession);
	}

	@Override
	public int selectListCount() {
		return visitDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Visit> selectList(PageInfo pi) {
		return visitDao.selectList(sqlSession, pi);
	}
	
	@Override
	public int selectCategoryListCount(String category) {
		return visitDao.selectCategoryListCount(sqlSession, category);
	}

	@Override
	public ArrayList<Visit> selectCategoryList(String category, PageInfo pi) {
		return visitDao.selectCategoryList(sqlSession, category, pi);
	}
	
	@Override
	public int selectStatusListCount(String statusCategory) {
		return visitDao.selectStatusListCount(sqlSession, statusCategory);
	}

	@Override
	public ArrayList<Visit> selectStatusList(String statusCategory, PageInfo pi) {
		return visitDao.selectStatusList(sqlSession, statusCategory, pi);
	}


	@Override
	public Visit selectVisit(int visitNo) {
		return visitDao.selectVisit(sqlSession, visitNo);
	}

	@Override
	public int okReserveStatus(int visitNo) {
		return visitDao.okReserveStatus(sqlSession, visitNo);
	}

	@Override
	public int noReserveStatus(int visitNo) {
		return visitDao.noReserveStatus(sqlSession, visitNo);
	}

	@Override
	public int cancelStatus(int visitNo) {
		return visitDao.cancelStatus(sqlSession, visitNo);
	}

	@Override
	public int cancelReserveStatus(int visitNo) {
		return visitDao.cancelReserveStatus(sqlSession, visitNo);
	}


	
	

}
