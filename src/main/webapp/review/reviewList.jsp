<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.PageDTO"%>
<%@page import="com.example.domain.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.ReviewDAO"%>
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
ReviewDAO reviewDAO = ReviewDAO.getInstance();
// review 테이블에서 전체글 리스트로 가져오기 
List<ReviewVO> reviewList = reviewDAO.getReviews(cri);

// 전체 글개수 가져오기
int totalCount = reviewDAO.getCountBySearch(cri); // 검색유형, 검색어가 있으면 적용하여 글개수 가져오기

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
									<h3 class="font-weight-bold text-dark text-left ml-3 my-3"><a href="/review/reviewList.jsp" style="text-decoration: none; color:inherit;">리뷰 게시판</a></h3>
								</div>
							</div>
						</div>
					</div>

					<br>

					<!-- DataTales Example -->
					<div class="card shadow mb-0">
						<div class="table-responsive mt-3">
							<table class="table table-bordered table-hover table-sm mx-auto" style="text-overflow: ellipsis; width: 98%">

								<thead class="bg-dark text-light">
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>

								<tbody>
									<%
									if (pageDTO.getTotalCount() > 0) {

										SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

										for (ReviewVO reviewVO : reviewList) {
											String strRegDate = sdf.format(reviewVO.getRregDate());
									%>
									<tr onclick="location.href='/review/reviewView.jsp?num=<%=reviewVO.getRnum()%>&pageNum=<%=pageDTO.getCri().getPageNum()%>'">
										<td><%=reviewVO.getRnum()%></td>
										<td><%=reviewVO.getRsubject()%></td>
										<td><%=reviewVO.getRnick()%></td>
										<td><%=strRegDate%></td>
										<td><%=reviewVO.getRreadcount()%></td>
									</tr>
									<%
									} // for
									} else { // pageDTO.getTotalCount() == 0
									%>
									<tr>
										<td colspan="5">게시판 글이 없습니다.</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
					</div>

					<nav aria-label="Page navigation">
						<ul class="pagination justify-content-center my-2">
							<%
							// 이전
							if (pageDTO.isPrev()) {
							%>
							<li class="page-item"><a class="page-link"
								href="/review/reviewList.jsp?pageNum=<%=pageDTO.getStartPage() - 1%>&type=<%=pageDTO.getCri().getType()%>&keyword=<%=pageDTO.getCri().getKeyword()%>#review"
								aria-label="Previous"
							><span aria-hidden="true">&laquo;</span></a></li>
							<%
							}
							%>

							<%
							if (pageDTO.getEndPage() == 0) {
								%>
								<li class="page-item active"><a class="page-link">1</a></li>
								<%
							} else {
								// 페이지블록 내 최대 5개 페이지씩 출력
								for (int i = pageDTO.getStartPage(); i <= pageDTO.getEndPage(); i++) {
								%>
								<li class="page-item <%=(pageDTO.getCri().getPageNum() == i) ? "active" : ""%>"><a class="page-link"
									href="/review/reviewList.jsp?pageNum=<%=i%>&type=<%=pageDTO.getCri().getType()%>&keyword=<%=pageDTO.getCri().getKeyword()%>#review"
								><%=i%></a></li>
								<%
								}
							}
							%>

							<%
							// 다음
							if (pageDTO.isNext()) {
							%>
							<li class="page-item"><a class="page-link"
								href="/review/reviewList.jsp?pageNum=<%=pageDTO.getEndPage() + 1%>&type=<%=pageDTO.getCri().getType()%>&keyword=<%=pageDTO.getCri().getKeyword()%>#review" aria-label="Next"
							><span aria-hidden="true">&raquo;</span></a></li>
							<%
							}
							%>
						</ul>
						<%
						if (id != null) {
						%>
						<a href="/review/reviewWrite.jsp" class="position-absolute" style="margin-top: -45px">
							<button type="button" class="btn btn-dark ">글쓰기</button>
						</a>
						<%
						}
						%>
					</nav>

					<form method="GET" id="frm">
						<div class="input-group mx-auto my-4" style="width: 25%">
							<div class="input-group-prepend">
								<select class="btn btn-dark px-2" name="type">
									<option value="" disabled selected>선택</option>
									<option value="subject" <%=(pageDTO.getCri().getType().equals("subject")) ? "selected" : ""%>>제목</option>
									<option value="content" <%=(pageDTO.getCri().getType().equals("content")) ? "selected" : ""%>>내용</option>
									<option value="nick" <%=(pageDTO.getCri().getType().equals("nick")) ? "selected" : ""%>>작성자</option>
								</select>
							</div>
							<input type="text" class="form-control" name="keyword">
							<div class="input-group-append">
								<button class="btn btn-dark px-3" type="button" id="btnSearch">검색</button>
							</div>
						</div>
					</form>

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
		// 검색 버튼 클릭시
		$('#btnSearch').on('click', function() {

			var query = $('#frm').serialize();

			location.href = '/review/reviewList.jsp?' + query + '#review';
		});
	</script>
</body>

</html>