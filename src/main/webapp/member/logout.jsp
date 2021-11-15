<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 로그아웃
session.invalidate();

// 쿠키 가져오기
Cookie[] cookies = request.getCookies();

// 특정 쿠키 삭제
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("loginId")) {
	cookie.setMaxAge(0); // 쿠키 유효기간 0초 설정(삭제 의도)
	cookie.setPath("/");
	response.addCookie(cookie); // 응답객체에 추가하기
		}
	}
}

response.sendRedirect("/member/login.jsp"); // 로그인 화면으로 이동
%>
