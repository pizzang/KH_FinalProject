package com.kh.apartmentor.board.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
@AllArgsConstructor
public class Board {

	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardWriter;
	private String originName;
	private String changeName;
	private int count;
	private String createDate;
	private String status;
	private String boardCategory;
	private int userNo;
}
