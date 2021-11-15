<%@page import="com.example.repository.MemberDAO"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="memberVO" class="com.example.domain.MemberVO" />

<jsp:setProperty property="*" name="memberVO" />

<%
memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));
%>

<%
// 비밀번호를 암호화
String passwd = memberVO.getPasswd();
String pwHash = BCrypt.hashpw(passwd, BCrypt.gensalt());
memberVO.setPasswd(pwHash); // 비밀번호를 문자열로 수정
%>

<%
// 생년월일 문자열에서 하이픈(-) 제거
String birthday = memberVO.getBirthday();
birthday = birthday.replace("-", ""); // 하이픈을 빈문자로 대체
memberVO.setBirthday(birthday);
%>

<%
MemberDAO memberDAO = MemberDAO.getInstance();
%>

<%
memberDAO.insert(memberVO);
%>

<script>
	alert('회원가입에 성공하였습니다.');
	location.href = '/member/login.jsp'; // 로그인 화면 요청
</script>