package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReviewVO {

	private Integer rnum;
	private String rsubject;
	private String rcontent;
	private String rnick;
	private String rmid;
	private Timestamp rregDate;
	private Integer rreadcount;

}