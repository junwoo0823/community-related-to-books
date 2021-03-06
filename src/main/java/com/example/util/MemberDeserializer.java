package com.example.util;

import java.lang.reflect.Type;
import java.sql.Timestamp;

import org.mindrot.jbcrypt.BCrypt;

import com.example.domain.MemberVO;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;

public class MemberDeserializer implements JsonDeserializer<MemberVO> {

	@Override
	public MemberVO deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
			throws JsonParseException {

		MemberVO memberVO = null;

		if (json.isJsonObject()) {
			JsonObject jsonObject = json.getAsJsonObject(); // {}

			memberVO = new MemberVO();
			memberVO.setId(jsonObject.get("id").getAsString());
			memberVO.setPasswd(jsonObject.get("passwd").getAsString());
			memberVO.setNickname(jsonObject.get("nickame").getAsString());
			memberVO.setBirthday(jsonObject.get("birthday").getAsString());
			memberVO.setEmail(jsonObject.get("email").getAsString());
			memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));

			// 비밀번호 암호화 수정하기
			String hashedPw = BCrypt.hashpw(memberVO.getPasswd(), BCrypt.gensalt());
			memberVO.setPasswd(hashedPw);

			// 생년월일 문자열에서 하이픈(-) 기호 제거하기
			String birthday = memberVO.getBirthday();
			birthday = birthday.replace("-", ""); // 하이픈 문자열을 빈문자열로 대체
			memberVO.setBirthday(birthday);
		}
		return memberVO;
	}
}
