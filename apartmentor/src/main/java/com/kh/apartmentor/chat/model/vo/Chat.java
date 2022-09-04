package com.kh.apartmentor.chat.model.vo;

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
public class Chat {

	private int chatNo;
	private String chatContent;
	private String chatSendDate;
	private String chatSendTime;
	private int chatCode;
	private String chatWriter;
	private int userNo;
}
