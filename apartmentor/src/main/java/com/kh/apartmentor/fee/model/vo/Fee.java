package com.kh.apartmentor.fee.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Fee {
	
	private int feeNo;
	private String aptNo;
	private String feeDate;
	private String dueDate;
	private String aptFee;
	
}