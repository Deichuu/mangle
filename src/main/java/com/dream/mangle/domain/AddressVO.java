package com.dream.mangle.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AddressVO {

	private String address_id;
	private String zonecode;
	private String roadAddress;
	private String jibunAddress;
	private String bname;
	private String detailAddress;
	
}
