package com.dream.mangle.domain;

import java.util.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@ToString
@Setter
public class MtoMboardVO {
	
	private long bno ;
	private String btitle ;
	private String bcontent ;
	private String bwriter ;
	private Date bregDate ;
	private Timestamp bmodDate ;
	private int bviewsCnt ;
	private int breplyCnt ;
	private int bdelFlag ;   //1: 삭제요청됨, 0: 유지
	private long rbno;
	
	private List<UploadFileVO> uploadFileList = new ArrayList<>();
	

	//마이바티스의 여러 오류를 해결하기 위해 반드시 추가합니다.
	public MtoMboardVO() {
		System.out.println("BoardVO의 기본생성자입니다.");
	}
	
	
	public MtoMboardVO(long bno, String btitle, String bcontent, String bwriter, int bviewsCnt, int breplyCnt,
			int bdelFlag, Date bregDate, Timestamp bmodDate) {
		this.bno = bno;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bwriter = bwriter;
		this.bviewsCnt = bviewsCnt;
		this.breplyCnt = breplyCnt;
		this.bdelFlag = bdelFlag;
		this.bregDate = bregDate;
		this.bmodDate = bmodDate;
		System.out.println("BoardVO의 All Arguement 생성자입니다.");
	}

	
	public void setBno(long bno) {
		this.bno = bno;
	}
	
	
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	
	
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	
	
	public void setBwriter(String bwriter) {
		this.bwriter = bwriter ;
	}

	
	public void setUploadFileList(List<UploadFileVO> uploadFileList) {
		this.uploadFileList = uploadFileList;
	}


	public void setBregDate(Date bregDate) {
		this.bregDate = bregDate;
	}


	public void setBmodDate(Timestamp bmodDate) {
		this.bmodDate = bmodDate;
	}


	public void setBviewsCnt(int bviewsCnt) {
		this.bviewsCnt = bviewsCnt;
	}


	public void setBreplyCnt(int breplyCnt) {
		this.breplyCnt = breplyCnt;
	}


	public void setBdelFlag(int bdelFlag) {
		this.bdelFlag = bdelFlag;
	}


	public void setRbno(long rbno) {
		this.rbno = rbno;
	}
}
