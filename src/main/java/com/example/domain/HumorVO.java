package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class HumorVO {

	private Integer hnum;
	private String hsubject;
	private String hcontent;
	private String hnick;
	private String hmid;
	private Timestamp hregDate;
	private Integer hreadcount;

}