package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeVO {

	private Integer nnum;
	private String nsubject;
	private String ncontent;
	private String nnick;
	private String nmid;
	private Timestamp nregDate;
	private Integer nreadcount;

}