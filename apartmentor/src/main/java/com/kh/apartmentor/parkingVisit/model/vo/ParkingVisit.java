package com.kh.apartmentor.parkingVisit.model.vo;

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
public class ParkingVisit {
	private String visitCarNo;
	private String carNo;
	private String visitCarPhone;
	private String visitCarDate;
	private String purpose;
	private String status;
	private int userNo;
	private String aptNo;
	
}
