<%@page import="com.example.domain.ReviewVO"%>
<%@page import="com.example.domain.NoticeVO"%>
<%@page import="com.example.domain.HumorVO"%>
<%@page import="com.example.repository.ReviewDAO"%>
<%@page import="com.example.repository.NoticeDAO"%>
<%@page import="com.example.repository.HumorDAO"%>
<%@page import="com.example.domain.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@page import="com.example.domain.Criteria"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// 글목록 가져오기 조건객체 준비
Criteria cri = new Criteria(); // 기본값 1페이지 10개

// 요청 페이지번호 파라미터값 가져오기
String strPageNum = request.getParameter("pageNum");
if (strPageNum != null) { // 요청 페이지번호 있으면
	cri.setPageNum(Integer.parseInt(strPageNum)); // cri에 값 설정
}

// DAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
HumorDAO humorDAO = HumorDAO.getInstance();
NoticeDAO noticeDAO = NoticeDAO.getInstance();
ReviewDAO reviewDAO = ReviewDAO.getInstance();

// 테이블에서 전체글 리스트로 가져오기 
List<BoardVO> boardList = boardDAO.getBoards(cri);
List<HumorVO> humorList = humorDAO.getHumors(cri);
List<NoticeVO> noticeList = noticeDAO.getNotices(cri);
List<ReviewVO> reviewList = reviewDAO.getReviews(cri);

// 페이지블록 정보 객체준비. 필요한 정보를 생성자로 전달.
PageDTO boardDTO = new PageDTO(cri, boardDAO.getCountBySearch(cri));
PageDTO humorDTO = new PageDTO(cri, humorDAO.getCountBySearch(cri));
PageDTO noticeDTO = new PageDTO(cri, noticeDAO.getCountBySearch(cri));
PageDTO reviewDTO = new PageDTO(cri, reviewDAO.getCountBySearch(cri));
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/include/head.jsp" />
<style>
h4 {
	text-align: center;
}

ul {
	display: block;
	white-space: normal;
	text-overflow: ellipsis;
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

					<div class="card o-hidden border-0 shadow pt-2" style="margin-bottom: -15px;">
						<div class="card-body p-0">
							<div class="row">
								<div class="col-lg-12 d-none d-lg-block center-block">
									<h3 class="font-weight-bold text-dark text-left ml-3 my-3">전체 글</h3>
								</div>
							</div>
						</div>
					</div>

					<br>

					<div class="row row-cols-1 row-cols-md-2 mt-2">

						<div class="col mb-3">
							<div class="card shadow" style="height: 360px;">
								<h4 class="card-header font-weight-bold">
									<a href="/notice/noticeList.jsp" style="text-decoration: none; color: inherit;">공지 사항</a>
								</h4>
								<div class="card-body" style="overflow: hidden; font-weight: bold;">
									<%
									if (noticeDTO.getTotalCount() > 0) {

										SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

										for (NoticeVO noticeVO : noticeList) {
											String strRegDate = sdf.format(noticeVO.getNregDate());
											%>
											<ul style="cursor: pointer;" onclick="location.href='/notice/noticeView.jsp?num=<%=noticeVO.getNnum()%>&pageNum=<%=noticeDTO.getCri().getPageNum()%>'">
												<li><%=noticeVO.getNsubject()%></li>
											</ul>
											<%
										} // for
									} else { // pageDTO.getTotalCount() == 0
									%>
									<ul>
										<li>게시판 글이 없습니다.</li>
									</ul>
									<%
									}
									%>
								</div>
							</div>
						</div>

						<div class="col mb-3">
							<div class="card shadow" style="height: 360px;">
								<h4 class="card-header font-weight-bold">
									<a href="/board/boardList.jsp" style="text-decoration: none; color: inherit;">자유 게시판</a>
								</h4>
								<div class="card-body" style="overflow: hidden;">
									<%
									if (boardDTO.getTotalCount() > 0) {

										SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

										for (BoardVO boardVO : boardList) {
											String strRegDate = sdf.format(boardVO.getRegDate());
											%>
											<ul style="cursor: pointer;" onclick="location.href='/board/boardView.jsp?num=<%=boardVO.getNum()%>&pageNum=<%=boardDTO.getCri().getPageNum()%>'">
												<li><%=boardVO.getSubject()%></li>
											</ul>
											<%
										} // for
									} else { // pageDTO.getTotalCount() == 0
									%>
									<ul>
										<li>게시판 글이 없습니다.</li>
									</ul>
									<%
									}
									%>
								</div>
							</div>
						</div>

						<div class="col mb-3">
							<div class="card shadow" style="height: 360px;">
								<h4 class="card-header font-weight-bold">
									<a href="/humor/humorList.jsp" style="text-decoration: none; color: inherit;">유머 게시판</a>
								</h4>
								<div class="card-body" style="overflow: hidden;">
									<%
									if (humorDTO.getTotalCount() > 0) {

										SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

										for (HumorVO humorVO : humorList) {
											String strRegDate = sdf.format(humorVO.getHregDate());
											%>
											<ul style="cursor: pointer;" onclick="location.href='/humor/humorView.jsp?num=<%=humorVO.getHnum()%>&pageNum=<%=humorDTO.getCri().getPageNum()%>'">
												<li><%=humorVO.getHsubject()%></li>
											</ul>
											<%
										} // for
									} else { // pageDTO.getTotalCount() == 0
									%>
									<ul>
										<li>게시판 글이 없습니다.</li>
									</ul>
									<%
									}
									%>
								</div>
							</div>
						</div>

						<div class="col mb-3">
							<div class="card shadow" style="height: 360px;">
								<h4 class="card-header font-weight-bold">
									<a href="/review/reviewList.jsp" style="text-decoration: none; color: inherit;">리뷰 게시판</a>
								</h4>
								<div class="card-body" style="overflow: hidden;">
									<%
									if (reviewDTO.getTotalCount() > 0) {

										SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

										for (ReviewVO reviewVO : reviewList) {
											String strRegDate = sdf.format(reviewVO.getRregDate());
											%>
											<ul style="cursor: pointer;" onclick="location.href='/review/reviewView.jsp?num=<%=reviewVO.getRnum()%>&pageNum=<%=reviewDTO.getCri().getPageNum()%>'">
												<li><%=reviewVO.getRsubject()%></li>
											</ul>
											<%
										} // for
									} else { // pageDTO.getTotalCount() == 0
									%>
									<ul>
										<li>게시판 글이 없습니다.</li>
									</ul>
									<%
									}
									%>
								</div>
							</div>
						</div>
					</div>

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