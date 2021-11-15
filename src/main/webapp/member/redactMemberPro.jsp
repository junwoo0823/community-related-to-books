<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="memberVO" class="com.example.domain.MemberVO" />

<jsp:setProperty property="*" name="memberVO" />

<%
memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));
%>

<%
// 생년월일에서 하이픈(-) 제거하기
String birthday = memberVO.getBirthday();
birthday = birthday.replace("-", ""); // 하이픈을 빈문자 대체
memberVO.setBirthday(birthday);
%>

<%
MemberDAO memberDAO = MemberDAO.getInstance();
%>

<%
MemberVO dbMemberVO = memberDAO.getMemberById(memberVO.getId());
%>

<%
// 비밀번호 일치하면 회원정보 수정하기
// if (memberVO.getPasswd().equals(dbMemberVO.getPasswd()))

if (BCrypt.checkpw(memberVO.getPasswd(), dbMemberVO.getPasswd()) == true) {

	memberDAO.updateById(memberVO); // 수정
%>
<script>
	alert('정보 수정 완료');
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
