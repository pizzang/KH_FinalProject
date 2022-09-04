package com.kh.apartmentor.notice.model.vo;

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
public class Notice {
	
	private	int	noticeNo;		
	private	String noticeTitle; 
	private	String noticeCategory;
	private	String noticeContent;
	private	int userNo;			
	private	String originName; 	
	private	String changeName;	
	private	String noticeCalender;
	private	String noticeStartDate;
	private	String noticeEndDate;
	private	Date createDate;	
	private	String status;
	
	private String userName;
	private String noticeCategoryValue;
    
}      
