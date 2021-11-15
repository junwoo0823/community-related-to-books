package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {

	private Integer num;
	private String subject;
	private String content;
	private String nick;
	private String mid;
	private Timestamp regDate;
	private Integer readcount;

}