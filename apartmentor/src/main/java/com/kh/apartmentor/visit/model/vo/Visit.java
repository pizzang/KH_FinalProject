package com.kh.apartmentor.visit.model.vo;

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
public class Visit {
	
	private int visitNo; //VISIT_NO	NUMBER
	private String visitCategory; //VISIT_CATEGORY	VARCHAR2(50 BYTE)
	private int userNo; //USER_NO	NUMBER
	private String visitDate; //VISIT_DATE	VARCHAR2(150 BYTE)
	private String visitTime; //VISIT_TIME	VARCHAR2(150 BYTE)
	private String visitStatus; //VISIT_STATUS	VARCHAR2(1 BYTE)
	private String visitContent; //VISIT_CONTENT	VARCHAR2(3000 BYTE)
	private Date CreateDate; //CREATE_DATE	DATE
	
	private String visitValue;
	private String aptNo;
	private String visitEmail;
	private String visitStatusValue;
	
	
}
