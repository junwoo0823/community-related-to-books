<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.ReviewVO"%>
<%@page import="com.example.repository.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("id");

// 상세보기 글번호 파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));

// 요청 페이지번호 파라미터값 가져오기
String pageNum = request.getParameter("pageNum");

// DAO객체 준비
ReviewDAO reviewDAO = ReviewDAO.getInstance();

// 조회수 1 증가시키기
reviewDAO.updateReadcount(num);

// 상세보기할 글 한개 가져오기
ReviewVO reviewVO = reviewDAO.getReview(num);

// 화면에 표시할 날짜형식
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (HH:mm)");
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/include/head.jsp" />

<style>
#content li {
	list-style-type: none;
	display: inline;
}

.list li:nth-child(n+2):before {
	content: "";
	padding: 0 3px;
	border-left: 1px solid gray;
}

#description {
	padding: 20px 0;
	border-top: 1px solid gray;
}

#solidLine {
	border-top: 1px solid gray;
	margin: 15px 0;
}

#dashedLine {
	border-top: 1px dashed lightgray;
	margin: 15px 0;
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
						<input type="hidden" id="mid" name="mid" value="<%=reviewVO.getRmid()%>">

						<div class="text-dark mx-auto mt-4" style="width: 98%">
							<h3 class="font-weight-bold text-left"><%=reviewVO.getRsubject()%></h3>
							<div>
								<ul class="list" style="margin-left: -40px;">
									<li>&nbsp;<b><%=reviewVO.getRnick()%></b>&nbsp;
									</li>
									<li>&nbsp;<b>조회수</b>&nbsp;<%=reviewVO.getRreadcount()%>&nbsp;
									</li>
									<li>&nbsp;<b>작성일</b>&nbsp;<%=sdf.format(reviewVO.getRregDate())%>&nbsp;
									</li>
								</ul>
							</div>
							<div id="solidLine"></div>
							<div>
								<%=reviewVO.getRcontent()%>
							</div>
							<div class="btn-toolbar my-2">
								<div class="btn-group mr-2">
									<button type="button" class="btn btn-secondary" onclick="location.href = '/review/reviewList.jsp'">글목록</button>
									<%
									if (id != null) { // 로그인 확인
									%>
									<button type="button" class="btn btn-dark" onclick="location.href='/review/reviewWrite.jsp'">글쓰기</button>
									<%
									}
									%>
								</div>

								<%
								if (id != null) { // 로그인 확인
									if (id.equals(reviewVO.getRmid()) || id.equals("admin")) { // 본인 일 때만
								%>
								<div class="btn-group">
									<button type="button" class="btn btn-primary" onclick="location.href='/review/reviewModify.jsp?num=<%=reviewVO.getRnum()%>&pageNum=<%=pageNum%>'">수정</button>
									<button type="button" class="btn btn-danger" onclick="remove(event)">삭제</button>
								</div>
								<%
								}
								}
								%>
							</div>
							<div id="dashedLine"></div>
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
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<jsp:include page="/include/modal.jsp" />
	<!-- End of Logout Modal-->

	<!-- Scripts -->
	<jsp:include page="/include/commonJs.jsp" />

	<script>
    // 글삭제 버튼을 클릭하면 호출되는 함수
  	function remove(event) {
    	event.preventDefault(); // a태그 기본동작 막기
    	
  		var isRemove = confirm('이 글을 삭제하시겠습니까?');
  		if (isRemove == true) {
  			location.href = '/review/reviewRemove.jsp?num=<%=reviewVO.getRnum()%>&pageNum=<%=pageNum%>';
			}
		}
	</script>
</body>

</html>