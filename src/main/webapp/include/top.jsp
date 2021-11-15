<%@page import="com.example.repository.MemberDAO"%>
<%@page import="com.example.domain.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("id");
%>

<%
MemberDAO memberDAO = MemberDAO.getInstance();
MemberVO memberVO = memberDAO.getMemberById(id);
%>

<nav class="navbar topbar fixed-top navbar-expand navbar-light bg-gray-900 fixed mb-4 shadow">

	<!-- logo -->
	<a href="/index.jsp"><img src="/resources/img/Logo.png" style="width: 200px;"></a>

	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">

		<!-- Nav Item - User Information -->
		<%
		if (id == null) {
		%>
		<!-- 로그아웃 상태일때 -->
		<li class="nav-item dropdown no-arrow"><a class="nav-link dropdown-toggle  text-gray-600" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"
		><i class="fas fa-ellipsis-v"></i> </a> <!-- Dropdown - User Information -->
			<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
				<a class="dropdown-item" href="/member/login.jsp"> <i class="fas fa-door-open fa-sm fa-fw mr-2 text-gray-400"></i>로그인
				</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="/member/signUp.jsp"><i class="fab fa-fort-awesome fa-sm fa-fw mr-2 text-gray-400"></i>회원가입 </a>
			</div></li>
		<%
		} else {
		%>
		<!-- 로그인 상태일때 -->
		<li class="nav-item dropdown no-arrow"><a class="nav-link dropdown-toggle  text-gray-600" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"
		> <% 
		if (id.equals("admin")) {
			%> <span class="mr-2 pt-1 d-none d-lg-inline small font-weight-bold text-warning"><%=memberVO.getNickname()%></span> <i class="fas fa-crown text-warning"></i> <%
		} else {
			%> <span class="mr-2 pt-1 d-none d-lg-inline small text-light"><%=memberVO.getNickname()%></span> <i class="fas fa-ghost text-light"></i> <%
		}
		%></a>
		<!-- Dropdown - User Information -->
			<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
				<a class="dropdown-item" href="/member/identifyMember.jsp"> <i class="fas fa-user-edit fa-sm fa-fw mr-2 text-gray-400"></i>내 정보
				</a> <a class="dropdown-item" href="/member/logout.jsp" data-toggle="modal" data-target="#logoutModal"> <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>로그아웃
				</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="/member/deleteMember.jsp"> <i class="fas fa-times-circle fa-sm fa-fw mr-2 text-gray-400"></i>회원탈퇴
				</a>
			</div></li>
		<%
		}
		%>

	</ul>

</nav>