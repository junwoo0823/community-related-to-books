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
				<div class="container-fluid" style="padding-top: 200px; padding-left: 250px;">
					<!-- Outer Row -->
					<div class="row justify-content-center h-0 my-5">

						<div class="col-4">

							<div class="card o-hidden border-0 shadow-lg pt-2" style="margin-bottom: -10px;">
								<div class="card-body p-0">
									<div class="row">
										<div class="col-lg-12 d-none d-lg-block center-block">
											<h3 class="font-weight-bold text-dark text-left ml-3 my-3">회원 탈퇴</h3>
										</div>
									</div>
								</div>
							</div>

							<br>

							<div class="card o-hidden border-0 shadow p-3">
								<div class="card-body p-0">
									<!-- Nested Row within Card Body -->
									<div class="row">
										<div class="col-lg-12 d-none d-lg-block center-block">

											<form action="/member/deleteMemberPro.jsp" method="post" id="frm" name="frm" class="user">
												<div class="form-group">
													<label for="id" class="cols-sm-2 control-label font-weight-bold"> &nbsp;<i class="fas fa-id-card"></i>&nbsp;&nbsp;아이디
													</label>
													<div class="cols-sm-10">
														<div class="input-group">
															<input type="text" class="form-control form-control-user" name="id" id="id" value="<%=memberVO.getId()%>" readonly />
														</div>
													</div>
												</div>

												<div class="form-group">
													<label for="passwd" class="cols-sm-2 control-label font-weight-bold"> &nbsp;<i class="fas fa-unlock"></i>&nbsp;&nbsp;비밀번호 확인
													</label>
													<div class="cols-sm-10">
														<div class="input-group">
															<input type="password" class="form-control form-control-user" name="passwd" id="passwd" />
														</div>
													</div>
												</div>

												<!-- Divider -->
												<hr class="dropdown-divider d-none d-md-block">

												<button class="btn btn-secondary btn-user btn-block font-weight-bold" id="redact" type="submit">
													<span class="text mx-2">탈퇴하기</span>
												</button>
											</form>
										</div>
									</div>
									<!-- End of  Nested Row within Card Body -->
								</div>
							</div>

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

	<script>
		$('form#frm').on('submit', function(event) {
			var isDelete = confirm('정말로 탈퇴 하시겠습니까?'); // true/false 리턴

			if (isDelete == false) {
				event.preventDefault(); // form태그의 기본동작 막기
			}
		});
	</script>
</body>

</html>