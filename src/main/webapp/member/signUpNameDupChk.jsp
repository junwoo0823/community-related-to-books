<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String nickname = request.getParameter("nickname");

MemberDAO memberDAO = MemberDAO.getInstance();

// 닉네임 중복 확인
int count = memberDAO.getCountByNickname(nickname); // count -> 1:중복, 0:중복X
%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
</head>
<body>

	<!-- Topbar -->
	<nav class="navbar topbar fixed-top navbar-expand navbar-light bg-gray-900 fixed mb-4 shadow">

		<!-- Sidebar - Brand -->
		<a class="d-flex text-gray-200 align-items-center justify-content-center" style="font-family: itim; text-decoration-line: none;">
			<div>
				<img src="/resources/img/Logo.png" style="width: 200px;">
			</div>
		</a>
	</nav>
	<!-- End of Topbar -->

	<br><br>
	<br><br>

	<div id="content">
		<%
		if (count == 1) {
			%>
			<p class="text-danger ml-3">
				<i class="fas fa-comment-slash"></i>&nbsp;이미 사용중인 닉네임 입니다.
			</p>
			<%
		} else { // count == 0
			%>
			<p class="text-primary ml-3">
				<i class="fas fa-comment"></i>&nbsp;<%=nickname%>는 사용가능한 닉네임 입니다.
			</p>
			<button type="button" class="btn btn-primary btn-sm ml-3" id="btnUseName">사용하기</button>
			<%
		}
		%>

		<hr>

		<form action="/member/signUpNameDupChk.jsp" method="get" name="frm">
			<input type="text" class="ml-3" id="reNick" name="nickname" value="<%=nickname%>">
			<button type="submit" class="btn btn-dark btn-sm ml-2" id="btnReName">중복 확인</button>
		</form>

	</div>

	<!-- Scripts -->
	<jsp:include page="/include/commonJs.jsp" />

	<script src="/resources/js/jquery-3.6.0.js"></script>

	<script>
		
		$('button#btnReName').on('click', function () {
			var reNick = $('input#reNick').val();
			
			if (reNick == '') {
				event.preventDefault();
				alert('아이디를 입력해주세요.');
				$('input#reNick').focus();
				return;
			}			
		});
	
		$('button#btnUseName').on('click', function() {
			var reNick = $('input#reNick').val();
			
			if (reNick == '') {
				event.preventDefault();
				alert('아이디를 입력해주세요.');
				$('input#reNick').focus();
				return;
			}
			
			// 닉네임 중복 체크 완료 후 넣기
			window.opener.document.frm.nickname.value = frm.nickname.value;
			// 창닫기
			close();
		});
	</script>
</body>
</html>








