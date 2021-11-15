<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
				<div class="container-fluid" style="padding-top: 100px; padding-left: 250px;">

					<!-- Outer Row -->
					<div class="row justify-content-center h-0" style="height: 770px;">

						<div class="col-xl-10 col-lg-12 col-md-9">

							<div class="card o-hidden border-0 shadow-lg" style="margin-top: 150px;">
								<div class="card-body p-0">
									<!-- Nested Row within Card Body -->
									<div class="row bg-gray-100">
										<div class="col-lg-6 d-none d-lg-block" style="background-image: url(/resources/img/loginImage.jpg);"></div>
										<div class="col-lg-6">
											<div class="p-5">

												<div class="text-center">
													<h1 class="h4 text-gray-800 mb-4 font-weight-bold">
														welcome to <b>BooKnowledge</b>!
													</h1>
												</div>

												<form action="/member/loginPro.jsp" method="POST" class="user">

													<div class="form-group">
														<input type="text" class="form-control form-control-user" id="id" name="id" placeholder="ID">
													</div>
													<div class="form-group">
														<input type="password" class="form-control form-control-user" id="passwd" name="passwd" placeholder="Password">
													</div>
													<div class="form-group text-center">
														<div class="custom-control custom-checkbox small">
															<input type="checkbox" class="custom-control-input" id="remember" name="remember">
															<label class="custom-control-label" for="remember">로그인 유지</label>
														</div>
													</div>
													<button class="btn btn-secondary btn-user btn-block font-weight-bold" type="submit">LOGIN</button>

												</form>

												<hr>

												<div class="text-center">
													<p class="small">
														혹시 계정이 없으신가요?&nbsp;&nbsp;<a href="/member/signUp.jsp">Sign Up</a>
													</p>
												</div>
											</div>
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
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<jsp:include page="/include/modal.jsp" />
	<!-- End of Logout Modal-->

	<!-- Scripts -->
	<jsp:include page="/include/commonJs.jsp" />

</body>

</html>