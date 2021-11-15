<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("id");
String passwd = request.getParameter("passwd");

MemberDAO memberDAO = MemberDAO.getInstance();
MemberVO memberVO = memberDAO.getMemberById(id);

if (BCrypt.checkpw(passwd, memberVO.getPasswd()) == true) {

	memberDAO.deleteById(id); // DB 레코드 삭제

	session.invalidate(); // 세션 비우기

	// 쿠키값 가져오기
	Cookie[] cookies = request.getCookies();

	// 특정 쿠키 삭제하기
	if (cookies != null) {
		for (Cookie cookie : cookies) {
	if (cookie.getName().equals("loginId")) {
		cookie.setMaxAge(0); // 0초 설정은 삭제 의도
		cookie.setPath("/");
		response.addCookie(cookie); // 응답객체에 추가하기
	}
		}
	}
%>
<script>
	alert('계정이 탈퇴되었습니다.');
	location.href = '/index.jsp';
</script>
<%
} else {
%>
<script>
	alert('등록했던 비밀번호와 같지 않습니다.');
	history.back();
</script>
<%
}
%>
