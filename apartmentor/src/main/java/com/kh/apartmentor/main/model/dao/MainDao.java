package com.kh.apartmentor.main.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.apartmentor.board.model.vo.Board;
import com.kh.apartmentor.common.model.vo.Reserve;
import com.kh.apartmentor.notice.model.vo.Notice;
import com.kh.apartmentor.visit.model.vo.Visit;
@Repository
public class MainDao {

	public ArrayList<Board> boardList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.boardList");
	}

	public ArrayList<Notice> noticeList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.noticeList");
	}

	public ArrayList<Visit> visitReserveList(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("mainMapper.visitReserveList", userNo);
	}

	public ArrayList<Reserve> reserveReserveList(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("mainMapper.reserveReserveList", userNo);
	}

	public ArrayList<Notice> noticeReserveList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.noticeReserveList");
	}

}
