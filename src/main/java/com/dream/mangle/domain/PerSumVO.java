package com.dream.mangle.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PerSumVO {
//	<id column="ORDERDATE" property="ORDERDATE" jdbcType="VARCHAR"/>
//	<id column="sale" property="sale" jdbcType="VARCHAR"/>
	
	public String orderDate;
	public int sale;
}
