package com.kh.apartmentor.fee.model.service;

import java.util.ArrayList;

import com.kh.apartmentor.fee.model.vo.Fee;

public interface FeeService {
	
	ArrayList<Fee> selectFeeList(int userNo);

}
