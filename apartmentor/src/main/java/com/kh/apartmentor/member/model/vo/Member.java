package com.kh.apartmentor.member.model.vo;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter@Setter
@ToString
public class Member {
	private int userNo;		
	private String aptNo;	
	private String userId;	
	private String userPwd;	
	private String userName;
	private String birthday;
	private String phone;	
	private String email;	
	private String status;	
}
