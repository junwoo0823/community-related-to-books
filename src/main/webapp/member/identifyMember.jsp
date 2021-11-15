<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 세션에서 로그인 아이디 가져오기
String id = (String) session.getAttribute("id");

// DAO 객체 준비
MemberDAO memberDAO = MemberDAO.getInstance();

// 아이디에 해당하는 자신의 정보를 DB에서 가져오기
MemberVO memberVO = memberDAO.getMemberById(id);

// input type="date" 태그에 설정가능한 값이 되도록 생년월일 문자열을 변경하기
String birthday = memberVO.getBirthday(); // "20020127" -> "2002-01-27"

// 문자열 -> Date 객체 변환
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Date date = sdf.parse(birthday); // 생년월일 문자열을 Date 객체로 변환

// Date 객체 -> 문자열 변환
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String strBirthday = sdf2.format(date);
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/include/head.jsp" />
</head>

<body class="bg-gray-100" id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Topbar -->
		<jsp:include page="/include/top.jsp" />
		<!-- End of Topbar -->

		<!-- Sidebar -->
		<jsp:include page="/include/side.jsp" />
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Begin Page Content -->
				<div class="container-fluid" style="padding-top: 40px; padding-left: 250px;">
					<!-- Outer Row -->
					<div class="row justify-content-center h-0 my-5">

						<div class="col-4">

							<div class="card o-hidden border-0 shadow-lg pt-2" style="margin-bottom: -10px;">
								<div class="card-body p-0">
									<div class="row">
										<div class="col-lg-12 d-none d-lg-block center-block">
											<h3 class="font-weight-bold text-dark text-left ml-3 my-3">내 정보</h3>
										</div>
									</div>
								</div>
							</div>

							<br>

							<div class="card o-hidden border-0 shadow-lg p-3" style="height: 450px;">
								<div class="card-body pt-5">
									<!-- Nested Row within Card Body -->
									<div class="row">
										<div class="col-lg-12 d-none d-lg-block center-block">

											<div class="form-group">
												<label for="id" class="cols-sm-2 control-label"> &nbsp;<i class="fas fa-id-card"></i>&nbsp;&nbsp;아이디 : <%=memberVO.getId()%>
												</label>
											</div>

											<div class="form-group">
												<label for="nickname" class="cols-sm-2 control-label"> &nbsp;<i class="fas fa-mask"></i>&nbsp;&nbsp;닉네임 : <%=memberVO.getNickname()%>
												</label>
											</div>

											<div class="form-group">
												<label for="birthday" class="cols-sm-2 control-label"> &nbsp;<i class="far fa-calendar-check"></i>&nbsp;&nbsp;생년월일 : <%=strBirthday%>
												</label>
											</div>

											<div class="form-group">
												<label for="name" class="cols-sm-2 control-label"> &nbsp;<i class="fas fa-envelope"></i>&nbsp;&nbsp;이메일 : <%=memberVO.getEmail()%>
												</label>
											</div>

											<div class="form-group">
												<label for="regDate" class="cols-sm-2 control-label"> &nbsp;<i class="fas fa-clock"></i>&nbsp;&nbsp;가입일 : <%=memberVO.getRegDate()%>
												</label>
											</div>

											<!-- Divider -->
											<hr class="sidebar-divider d-none d-md-block">

											<button class="btn btn-secondary btn-user btn-block" onclick="location.href='/member/redactMember.jsp'">수정하기</button>
										</div>
									</div>
									<!-- End of  Nested Row within Card Body -->
								</div>
							</div>
							<br>
						</div>

					</div>
					<!-- End of Outer Row -->
				</div>
				<!-- End of Begin Page Content -->

			</div>
			<!-- End of Main Content -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i></a>

	<!-- Logout Modal-->
	<jsp:include page="/include/modal.jsp" />
	<!-- End of Logout Modal-->

	<!-- Scripts -->
	<jsp:include page="/include/commonJs.jsp" />
</body>

</html>