package com.kh.apartmentor.vote.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Vote {
	
	private int voteNo;
	private String voteTitle;
	private Date voteStart;
	private Date voteEnd;
	private Date voteCreate;
	private int voteType;
	private String status;
	

}
