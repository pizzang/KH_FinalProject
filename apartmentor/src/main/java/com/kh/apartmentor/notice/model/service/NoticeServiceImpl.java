package com.kh.apartmentor.notice.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.notice.model.dao.NoticeDao;
import com.kh.apartmentor.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public int insertNotice(Notice n) {
		return noticeDao.insertNotice(sqlSession, n);
	}

	@Override
	public int selectListCount() {
		return noticeDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> selectList(PageInfo pi) {
		return noticeDao.selectList(sqlSession, pi);
	}

	@Override
	public int selectCategoryListCount(String category) {
		return noticeDao.selectCategoryListCount(sqlSession, category);
	}

	@Override
	public ArrayList<Notice> selectCategoryList(String category, PageInfo pi) {
		return noticeDao.selectCategoryList(sqlSession, category, pi);
	}

	@Override
	public int searchListCount(HashMap map) {
		return noticeDao.searchListCount(sqlSession, map);
	}

	@Override
	public ArrayList<Notice> searchList(HashMap map, PageInfo pi) {
		return noticeDao.searchList(sqlSession, map, pi);
	}

	@Override
	public Notice selectNotice(int noticeNo) {
		return noticeDao.selectNotice(sqlSession, noticeNo);
	}

	@Override
	public int updateNotice(Notice n) {
		return noticeDao.updateNotice(sqlSession, n);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(sqlSession, noticeNo);
	}

}
