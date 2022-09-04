package com.kh.apartmentor.vote.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.vote.model.vo.Vote;
import com.kh.apartmentor.vote.model.vo.VoteItem;

@Repository
public class VoteDao {

	public int insertVote(Vote v, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("voteMapper.insertVote", v);
	}

	public int insertVoteItem(List<VoteItem> voteItemList, SqlSessionTemplate sqlSession) {
		
		return sqlSession.insert("voteMapper.insertVoteItem", voteItemList);
	}

	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("voteMapper.selectListCount");
		
	}

	public ArrayList<Vote> selectVoteList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("voteMapper.selectVoteList", null, rowBounds);
	}

	public int setVoteStatus(SqlSessionTemplate sqlSession) {
		return sqlSession.update("voteMapper.setVoteStatus");
	}

	public int selectCategoryListCount(SqlSessionTemplate sqlSession, String category) {
		return sqlSession.selectOne("voteMapper.selectCategoryListCount", category);
	}

	public ArrayList<Vote> selectCategoryList(SqlSessionTemplate sqlSession, String keyword, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("voteMapper.selectCategoryList", keyword, rowBounds);
	}

	public int searchListCount(SqlSessionTemplate sqlSession,String keyword) {
		return sqlSession.selectOne("voteMapper.searchListCount", keyword);
	}

	public ArrayList<Vote> selectSearchList(SqlSessionTemplate sqlSession, String keyword, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("voteMapper.selectSearchList", keyword, rowBounds);
	}

	public Vote selectVote(SqlSessionTemplate sqlSession, int voteNo) {
		return sqlSession.selectOne("voteMapper.selectVote", voteNo);
	}

	public ArrayList<VoteItem> selectVoteItem(SqlSessionTemplate sqlSession, int voteNo) {
		return (ArrayList)sqlSession.selectList("voteMapper.selectVoteItem", voteNo);
	}

	public int submitVote(SqlSessionTemplate sqlSession, VoteItem vi) {
		return sqlSession.insert("voteMapper.submitVote", vi);
	}

	public int chkVoteMember(SqlSessionTemplate sqlSession, VoteItem voteMember) {
		return sqlSession.selectOne("voteMapper.chkVoteMember", voteMember);
	}

	public int increaseItemCount(SqlSessionTemplate sqlSession, int itemNo) {
		return sqlSession.update("voteMapper.increaseItemCount", itemNo);
	}

	public int totalCount(SqlSessionTemplate sqlSession, int voteNo) {
		return sqlSession.selectOne("voteMapper.totalCount", voteNo);
	}

	public List<VoteItem> selectVoteMember(SqlSessionTemplate sqlSession, VoteItem vi) {
		return sqlSession.selectList("voteMapper.selectVoteMember", vi);
	}

	public int decreaseItemCount(SqlSessionTemplate sqlSession, List<VoteItem> viList) {
		return sqlSession.update("voteMapper.decreaseItemCount", viList);
	}

	public int deleteVoteMember(SqlSessionTemplate sqlSession, VoteItem vi) {
		return sqlSession.delete("voteMapper.deleteVoteMember", vi);
	}

	public int deleteVote(SqlSessionTemplate sqlSession, int voteNo) {
		return sqlSession.update("voteMapper.deleteVote", voteNo);
	}

}
