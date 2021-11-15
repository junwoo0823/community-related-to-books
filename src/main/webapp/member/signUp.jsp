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
				<div class="container-fluid" style="padding-top: 70px; padding-left: 250px;">
					<!-- Outer Row -->
					<div class="row justify-content-center h-0 my-3">

						<div class="col-4">

							<div class="card o-hidden border-0 shadow-lg pt-2" style="margin-bottom: -10px;">
								<div class="card-body p-0">
									<div class="row">
										<div class="col-lg-12 d-none d-lg-block center-block">
											<h3 class="font-weight-bold text-dark text-left ml-3 my-3">회원 가입</h3>
										</div>
									</div>
								</div>
							</div>

							<br>

							<div class="card o-hidden border-0 shadow-lg p-4">
								<div class="card-body p-0">
									<!-- Nested Row within Card Body -->
									<div class="row">
										<div class="col-lg-12 d-none d-lg-block center-block">
											<form action="/member/signUpPro.jsp" method="post" id="frm" name="frm" class="user">
												<div class="form-group">
													<label for="id" class="cols-sm-2 control-label font-weight-bold"> &nbsp;<i class="fas fa-id-card"></i>&nbsp;&nbsp;아이디
													</label>
													<button type="button" class="btn btn-sm btn-danger mx-2" id="btnIdDupChk">중복 확인</button>
													<div class="cols-sm-10">
														<div class="input-group">
															<input type="text" class="form-control form-control-user" name="id" id="id" />
														</div>
													</div>
												</div>

												<div class="form-group">
													<label for="passwd" class="cols-sm-2 control-label font-weight-bold"> &nbsp;<i class="fas fa-unlock"></i>&nbsp;&nbsp;비밀번호
													</label>
													<div class="cols-sm-10">
														<div class="input-group">
															<input type="password" class="form-control form-control-user" name="passwd" id="passwd" />
														</div>
													</div>
												</div>

												<div class="form-group">
													<label for="passwd2" class="cols-sm-2 control-label font-weight-bold"> &nbsp;<i class="fas fa-unlock-alt"></i>&nbsp;&nbsp;비밀번호 재확인
													</label>
													<div class="cols-sm-10">
														<div class="input-group">
															<input type="password" class="form-control form-control-user" name="passwd2" id="passwd2" />
														</div>
													</div>
												</div>

												<!-- Divider -->
												<hr class="dropdown-divider d-none d-md-block">

												<div class="form-group">
													<label for="nickname" class="cols-sm-2 control-label font-weight-bold"> &nbsp;<i class="fas fa-mask"></i>&nbsp;&nbsp;닉네임
													</label>
													<button type="button" class="btn btn-sm btn-primary mx-2" id="btnNameDupChk">입력하기</button>
													<div class="cols-sm-10">
														<div class="input-group">
															<input type="text" class="form-control form-control-user" name="nickname" id="nickname" readonly />
														</div>
													</div>
													<label class="ml-3 text-danger"><small>* 닉네임은 가입 후 변경할 수 <strong>없습니다</strong>.
													</small></label>
												</div>

												<div class="form-group">
													<label for="birthday" class="cols-sm-2 control-label font-weight-bold"> &nbsp;<i class="far fa-calendar-check"></i>&nbsp;&nbsp;생년월일
													</label>
													<div class="cols-sm-10">
														<div class="input-group">
															<input type="date" class="form-control form-control-user" name="birthday" id="birthday" />
														</div>
													</div>
												</div>

												<div class="form-group">
													<label for="name" class="cols-sm-2 control-label font-weight-bold"> &nbsp;<i class="fas fa-envelope"></i>&nbsp;&nbsp;이메일
													</label>
													<div class="cols-sm-10">
														<div class="input-group">
															<input type="email" class="form-control form-control-user" name="email" id="email" placeholder="(선택 사항)" />
														</div>
													</div>
												</div>

												<!-- Divider -->
												<hr class="sidebar-divider d-none d-md-block">

												<button class="btn btn-secondary btn-user btn-block font-weight-bold" id="start" type="submit">
													<span class="text text-white mx-2">가입하기</span>
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

					<br>
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
		// 아이디 중복 확인 ajax
		$('button#btnIdDupChk').on('click', function() {

			var id = $('#id').val();

			// 공백인 경우
			if (id == '') {
				$('input#id').focus();
				return;
			}

			$.ajax({
				url : '/api/members/' + id,
				method : 'GET',
				success : function(data) {
					showData(data);
				}
			});
		});

		$('input[name=id]').on('keyup', function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^a-z0-9]/gi, ''));
			}
		});

		function showData(obj) {

			if (obj.count > 0) {
				alert('중복된 아이디입니다.');
				$('input#id').focus().val('');
				return;
			} else { // obj.count == 0
				alert('사용 가능한 아이디입니다.');
				$("input#id").attr("readonly", true);
			}
		} // showData

		// 닉네임 입력창
		$('button#btnNameDupChk').on('click', function() {
			var random = Math.floor((Math.random() + 1) * 99999999);

			// 열기
			open('/member/signUpNameDupChk.jsp?nickname=' + random, 'nameDupChk', 'width=500,height=250');
		});

		// #passwd2 요소에 포커스 아웃 이벤트 연결
		$('input#passwd2').on('focusout', function() {
			var passwd = $('input#passwd').val();
			var passwd2 = $(this).val();

			if (passwd != passwd2) {
				alert('비밀번호가 일치하지 않습니다.');
				$('input#passwd').addClass('bg-secondary')
						.addClass('text-white');
				$(this).addClass('bg-secondary').addClass(
						'text-white');
			} else {
				$('input#passwd').removeClass('bg-secondary')
						.removeClass('text-white');
				$(this).removeClass('bg-secondary')
						.removeClass('text-white');
			}
		});

		$('button#start').on('click', function(event) {
			var id = $('input#id').val();
			var passwd = $('input#passwd').val();
			var nickname = $('input#nickname').val();
			var birthday = $('input#birthday').val();
			var email = $('input#email').val();

			if (id == '') {
				event.preventDefault();
				alert('아이디를 입력해주세요.');
				$('input#id').focus();
				return;
			} else if (passwd == '') {
				event.preventDefault();
				alert('비밀번호를 입력해주세요.');
				$('input#passwd').focus();
				return;
			} else if (nickname == '') {
				event.preventDefault();
				alert('닉네임을 입력해주세요.');
				$('input#nickname').focus();
				return;
			} else if (birthday == '') {
				event.preventDefault();
				alert('생년월일을 입력해주세요.');
				$('input#birthday').focus();
				return;
			}
		});
	</script>
</body>

</html>