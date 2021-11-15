<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String remember = request.getParameter("remember");

MemberDAO memberDAO = MemberDAO.getInstance();
MemberVO memberVO = memberDAO.getMemberById(id);

if (memberVO != null) { // 아이디 일치

	if (BCrypt.checkpw(passwd, memberVO.getPasswd()) == true) { // 비밀번호 일치
		session.setAttribute("id", id);

		// 로그인 유지에 체크를 한 경우
		if (remember != null) {
		// 쿠키 생성
		Cookie cookie = new Cookie("loginId", id);
		cookie.setMaxAge(60 * 60 * 24 * 7); // 로그인 유지를 1주일로 설정.
	
		// 쿠키 경로설정
		cookie.setPath("/"); // 프로젝트 모든 경로에서 쿠키 받도록 설정.
	
		// 클라이언트로 보낼 쿠키를 response 응답객체에 추가하기. -> 응답시 쿠키도 함께 보냄.
		response.addCookie(cookie);
		}

		response.sendRedirect("/index.jsp");

	} else { // 비밀번호 불일치
	%>
	<script>
		alert('가입된 회원의 아이디가 아니거나 비밀번호가 틀렸습니다.');
		history.back(); // 뒤로가기
	</script>
	<%
	}
} else { // 아이디 불일치
%>
<script>
	alert('가입된 회원의 아이디가 아니거나 비밀번호가 틀렸습니다.');
	history.back(); // 뒤로가기
</script>
<%
}
%>