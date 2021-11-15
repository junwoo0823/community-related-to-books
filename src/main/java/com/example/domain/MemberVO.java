package com.example.domain;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class MemberVO {

	private String id;
	private String passwd;
	private String nickname;
	private String birthday;
	private String email;
	private Timestamp regDate;

	@Override
	public String toString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String strDate = sdf.format(regDate);

		StringBuilder builder = new StringBuilder();
		builder.append("MemberVO [id=").append(id).append(", passwd=").append(passwd).append(", nickname=")
				.append(nickname).append(", birthday=").append(birthday).append(", email=").append(email)
				.append(", regDate=").append(strDate).append("]");
		return builder.toString();
	}

}