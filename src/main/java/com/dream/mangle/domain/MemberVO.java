package com.dream.mangle.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
@AllArgsConstructor
public class MemberVO {
	private String userEmail;
	private String userPW;
	private String userName;
	private Date userRegdate;
	private Date userBirth;
	private String userMobile;
	private String userGrade;
	private String userCoupon;
	private int userPoint;
	private boolean enabled;
	
	private List<AuthorityVO> authorityList;
}
