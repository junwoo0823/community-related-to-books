<%@page import="com.example.repository.ReviewDAO"%>
<%@page import="com.example.domain.ReviewVO"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("id");
%>

<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
%>

<%
MemberDAO memberDAO = MemberDAO.getInstance();
MemberVO memberVO = memberDAO.getMemberById(id);

ReviewDAO reviewDAO = ReviewDAO.getInstance();
ReviewVO reviewVO = reviewDAO.getReview(num);
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/include/head.jsp" />
<!-- 에디터 스크립트 -->
<link href="https://cdn.jsdelivr.net/npm/suneditor@latest/dist/css/suneditor.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/dist/suneditor.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/suneditor@latest/src/lang/ko.js"></script>

<style>
/* 에디터 스타일 */
.sun-editor .se-placeholder {
	font-size: 18px !important;
	color: var(- -button-color) !important;
	padding-top: 11px !important;
}

.sun-editor .toolbar-file {
	position: absolute;
	left: 0;
	top: 0;
	bottom: 0;
	right: 0;
	display: block;
	width: 100%;
	height: 100%;
	opacity: 0;
	z-index: 10;
	cursor: pointer;
}

.sun-editor .sun-editor-editable * {
	line-height: 1 !important;
	font-size: 18px !important;
	color: var(- -content-color) !important;
}
</style>

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
			<div>

				<!-- Begin Page Content -->
				<div class="container-fluid" style="padding-top: 90px; padding-left: 250px;">

					<div class="card o-hidden border-0 shadow-lg pt-2" style="margin-bottom: -15px;">
						<div class="card-body p-0">
							<div class="row">
								<div class="col-lg-12 d-none d-lg-block center-block">
									<h3 class="font-weight-bold text-dark text-left ml-3 my-3"><a href="/review/reviewList.jsp" style="text-decoration: none; color:inherit;">리뷰 게시판</a></h3>
								</div>
							</div>
						</div>
					</div>

					<br>

					<div class="card shadow mb-0">
						<form action="/review/reviewModifyPro.jsp" method='post' id='formReview' name='formReview' enctype="multipart/form-data">
							<input type="hidden" name="pageNum" value="<%=pageNum%>">
							<input type="hidden" name="num" value="<%=reviewVO.getRnum()%>">
							<input type="hidden" name="nick" value="<%=memberVO.getNickname()%>">
							<input type="hidden" name="id" value="<%=id%>">

							<div class="mx-auto my-3" style="width: 98%">

								<div class="small-10 columns">
									<input class="form-control span12" type="text" id="subject" name="subject" value="<%=reviewVO.getRsubject()%>" />
								</div>

								<!-- 에디터 적용 -->
								<div class="small-10 columns" style="margin-top: 15px;">
									<textarea id="content" name="content"><%=reviewVO.getRcontent()%></textarea>
								</div>

								<!-- Divider -->
								<hr class="sidebar-divider">

								<div class="small-6 columns d-flex justify-content-center" style="margin-top: 15px;">
									<button type="button" class="btn btn-primary" onclick="getRegister();">수정 완료</button>
								</div>
							</div>

						</form>
					</div>
					<label><small>작성자 : <%=memberVO.getNickname()%> (<%=id%>)
					</small></label>
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

	<script>
		var editor_id = "content"; // 에디터 아이디
		var editor = SUNEDITOR
				.create(
						(document.getElementById(editor_id)),
						{
							"plugins" : [ {
								"name" : "customImage",
								"display" : "custom",
								"title" : "이미지",
								"innerHTML" : "<svg viewBox='0 0 15.75 15.77'><g><path d='M8.77,8.72a.88.88,0,0,1-.61-.27.82.82,0,0,1-.25-.61.89.89,0,0,1,.25-.62A.82.82,0,0,1,8.77,7a.81.81,0,0,1,.61.25.83.83,0,0,1,.27.62.81.81,0,0,1-.25.61.91.91,0,0,1-.63.27Zm9.62-5a1.74,1.74,0,0,1,1.76,1.76V17.76a1.74,1.74,0,0,1-1.76,1.76H6.16A1.74,1.74,0,0,1,4.4,17.76V5.51A1.74,1.74,0,0,1,6.16,3.75H18.39Zm0,1.75H6.16v8L8.53,11.8a.94.94,0,0,1,.54-.17.86.86,0,0,1,.54.2L11.09,13l3.64-4.55a.78.78,0,0,1,.34-.25.85.85,0,0,1,.42-.07.89.89,0,0,1,.39.12.78.78,0,0,1,.28.29l2.24,3.67V5.51Zm0,12.24V15.6L15.3,10.53,11.89,14.8a.89.89,0,0,1-.59.32.82.82,0,0,1-.64-.18L9,13.62,6.16,15.74v2Z' transform='translate(-4.4 -3.75)'></path></g></svg>",
							} ],
							"lang" : SUNEDITOR_LANG['ko'],
							"width" : "100%",
							"height" : 480,
							"imageWidth" : "auto",
							"imageResizing" : false,
							"imageHeightShow" : false,
							"imageRotation" : false,
							"imageFileInput" : false,
							"imageUrlInput" : false,
							"mediaAutoSelect" : false,
							"placeholder" : "내용을 입력해주세요.",
							"position" : "center",
							"popupDisplay" : "local",
							"buttonList" : [
									[ 'customImage', 'video' ],
									[ 'align', 'horizontalRule' ],
									[ 'fontSize' ],
									[ 'fontColor', 'hiliteColor' ],
									[ 'bold', 'italic', 'strike' ],
									[ 'link', 'removeFormat' ],
									[ 'showBlocks', 'codeView' ],
									[ 'fullScreen' ],
									[ '%800', [ [ 'customImage', 'video' ], ] ], ],
							"icons" : {
								"video" : "<svg viewBox='0 0 477.867 477.867'><g><path d='M238.933,0C106.974,0,0,106.974,0,238.933s106.974,238.933,238.933,238.933s238.933-106.974,238.933-238.933C477.726,107.033,370.834,0.141,238.933,0z M238.933,443.733c-113.108,0-204.8-91.692-204.8-204.8s91.692-204.8,204.8-204.8s204.8,91.692,204.8,204.8C443.611,351.991,351.991,443.611,238.933,443.733z'/></g><g><path d='M339.557,231.32c-1.654-3.318-4.343-6.008-7.662-7.662l-136.533-68.267c-8.432-4.213-18.682-0.794-22.896,7.638c-1.185,2.371-1.801,4.986-1.8,7.637V307.2c-0.004,9.426,7.633,17.07,17.059,17.075c2.651,0.001,5.266-0.615,7.637-1.8l136.533-68.267C340.331,250.004,343.762,239.756,339.557,231.32z M204.8,279.586v-81.306l81.306,40.653L204.8,279.586z'/></g></svg>",
							},
							"attributesWhitelist" : {
								"img" : "width|height|data-source_width|data-source_height"
							}
						});

		// 등록하기 버튼 클릭 시 실행
		function getRegister() {

			// 에디터 내용 저장
			editor.save();

			// 폼전송
			var f = document.formReview;
			f.submit();

		}

		// 이미지 업로드
		editor.onload = function(core) {

			var id = Math.round(Math.random() * 99999);

			core.codeViewDisabledButtons[0].outerHTML = "<input type='file' id='files_upload_" + id + "' accept='image/*' multiple='multiple' class='toolbar-file' />"
					+ core.codeViewDisabledButtons[0].outerHTML;

			document
					.getElementById("files_upload_" + id)
					.addEventListener(
							"change",
							function(e) {
								if (e.target.files) {
									//editor.insertImage(e.target.files)
									if (typeof window.FormData == 'undefined') {
										alert("지원하지 않는 브라우저입니다.");
										return true;
									}

									var el = e.target;
									var request = new XMLHttpRequest();
									request.open("POST",
											"/review/reviewImage.jsp", true);
									request.withCredentials = true;

									var formData = new FormData();
									for (var i = 0; i < el.files.length; i++) {
										formData.append("file[" + i + "]",
												el.files[i]);
									}
									request.send(formData);
									request.onload = function() {
										e.target.value = '';
										var result = JSON
												.parse(request.response);
										// 업로드 성공
										if (result.items && result.items.length) {
											var html = "";
											// server.xml에 <Context docBase="C:\download" path="/img/" reloadable="true"/> 추가하기
											for (var i = 0; i < result.items.length; i++) {
												html += "<img src=\"http://localhost:8090/img/" + result.items[i].name + "\"";
							                    html += " width=\"" + result.items[i].width + "\"";
							                    html += " height=\"" + result.items[i].height +"\"";
							                    html += "><p><br/></p>";
											}
											getImage(html);
										} else {
											// 실패 메시지
											alert(result.resultMessage);
										}
									};
								}
							});

		};

		function getImage(html) {

			if (!html)
				return false;
			var el = document.activeElement;
			if (!el || el && el.id !== editor_id) {
				editor.core.focus();
			}
			editor.insertHTML(html, true, true, false);
		}
	</script>

</body>

</html>