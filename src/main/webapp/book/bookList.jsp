<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.PageDTO"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@page import="com.example.domain.Criteria"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("id");
%>

<%
MemberDAO memberDAO = MemberDAO.getInstance();
MemberVO memberVO = memberDAO.getMemberById(id);
%>

<%
// 글목록 가져오기 조건객체 준비
Criteria cri = new Criteria(); // 기본값 1페이지 10개

// 요청 페이지번호 파라미터값 가져오기
String strPageNum = request.getParameter("pageNum");
if (strPageNum != null) { // 요청 페이지번호 있으면
	cri.setPageNum(Integer.parseInt(strPageNum)); // cri에 값 설정
}

//요청 글개수 파라미터값 가져오기
String strAmount = request.getParameter("amount");
if (strAmount != null) {
	cri.setAmount(Integer.parseInt(strAmount));
}

// 요청 검색유형 파라미터값 가져오기
String type = request.getParameter("type"); // null or ""
if (type != null && type.length() > 0) {
	cri.setType(type);
}
//요청 검색어 파라미터값 가져오기
String keyword = request.getParameter("keyword"); // null or ""
if (keyword != null && keyword.length() > 0) {
	cri.setKeyword(keyword);
}

// DAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
// board 테이블에서 전체글 리스트로 가져오기 
List<BoardVO> boardList = boardDAO.getBoards(cri);

// 전체 글개수 가져오기
int totalCount = boardDAO.getCountBySearch(cri); // 검색유형, 검색어가 있으면 적용하여 글개수 가져오기

// 페이지블록 정보 객체준비. 필요한 정보를 생성자로 전달.
PageDTO pageDTO = new PageDTO(cri, totalCount);
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/include/head.jsp" />
<style>
table {
	text-align: center;
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
			<div id="content">

				<!-- Begin Page Content -->
				<div class="container-fluid" style="padding-top: 90px; padding-left: 250px;">

					<div class="card o-hidden border-0 shadow-lg pt-2" style="margin-bottom: -15px;">
						<div class="card-body p-0">
							<div class="row">
								<div class="col-lg-12 d-none d-lg-block center-block">
									<h3 class="font-weight-bold text-dark text-left ml-3 my-3"><a href="/book/bookList.jsp" style="text-decoration: none; color:inherit;">도서 검색</a></h3>
								</div>
							</div>
						</div>
					</div>

					<br>

					<!-- DataTales Example -->
					<div class="card shadow mb-0">

						<div class="input-group mx-auto mt-3" style="width: 25%">
							<input type="text" class="form-control" id="bookName" placeholder="제목을 입력해주세요">
							<div class="input-group-append">
								<button class="btn btn-dark px-3" id="search">검색</button>
							</div>
						</div>

						<div class="table-responsive mt-3">
							<table class="table table-bordered table-sm mx-auto" style="text-overflow: ellipsis; width: 98%">

								<thead class="bg-dark text-light">
									<tr>
										<th>제목</th>
										<th>작가</th>
										<th>출판사</th>
										<th>ISBN</th>
									</tr>
								</thead>

								<tbody>
									<tr>
										<td id="title"></td>
										<td id="authors"></td>
										<td id="publisher"></td>
										<td id="isbn"></td>
									</tr>
								</tbody>
							</table>
						</div>

					</div>
					<!-- End of Begin Page Content -->

					<br>

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
		$("button#search").on('click', function() {
			$.ajax({
				method : "GET",
				url : "https://dapi.kakao.com/v3/search/book?target=title",
				data : { query : $("input#bookName").val() },
				headers : { Authorization : "KakaoAK ********************************" } // ******에는 kakao developers REST API 키를 입력  
			})
			.done(function(msg) {
				for (var i = 0; i < 10; i++) {
					$("td#title").append("<a href='"+ msg.documents[i].url +"'>&nbsp" + msg.documents[i].title + "</a><hr>");
					$("td#authors").append("&nbsp" + msg.documents[i].authors + "<hr>");
					$("td#publisher").append("&nbsp" + msg.documents[i].publisher + "<hr>");
					$("td#isbn").append("<a href='"+ msg.documents[i].url +"'>&nbsp" + msg.documents[i].isbn + "</a><hr>");
				}
			});
		});
		</script>
</body>

</html>