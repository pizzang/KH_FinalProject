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
public class VoteItem {
	
	private int itemNo;
	private int voteNo;
	private String itemName;
	private int userNo;
	private String originName;
	private String changeName;
	private int itemCount;

}