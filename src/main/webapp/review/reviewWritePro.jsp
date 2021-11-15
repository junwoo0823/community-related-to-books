<%@page import="java.sql.Timestamp"%>
<%@page import="com.example.domain.ReviewVO"%>
<%@page import="com.example.repository.ReviewDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String uploadFolder = "C:/kjw/upload"; // 업로드 기준경로

File uploadPath = new File(uploadFolder);

if (uploadPath.exists() == false) {
	uploadPath.mkdirs();
}

// 파일 업로드하기
MultipartRequest multi = new MultipartRequest(request, uploadPath.getPath(), 1024 * 1024 * 50, "utf-8", new DefaultFileRenamePolicy());

// ReviewDAO 객체 준비
ReviewDAO reviewDAO = ReviewDAO.getInstance();

// insert할 새 게시글 번호 가져오기
int num = reviewDAO.getNextrnum(); // attach 레코드의 bno 컬럼값에 해당함

// ReviewVO 객체 준비
ReviewVO reviewVO = new ReviewVO();

// 글번호 설정
reviewVO.setRnum(num);

// 파라미터값 가져와서 VO에 저장. MultipartRequest 로부터 가져옴.
reviewVO.setRsubject(multi.getParameter("subject"));
reviewVO.setRcontent(multi.getParameter("content"));
reviewVO.setRnick(multi.getParameter("nick"));
reviewVO.setRmid(multi.getParameter("id"));

// regDate  readcount
reviewVO.setRregDate(new Timestamp(System.currentTimeMillis()));
reviewVO.setRreadcount(0); // 조회수

// 주글 등록하기
reviewDAO.addReview(reviewVO);

// 요청 페이지번호 파라미터 가져오기
String pageNum = multi.getParameter("pageNum");

// 글상세보기 화면으로 이동
response.sendRedirect("/review/reviewView.jsp?num=" + reviewVO.getRnum() + "&pageNum=" + pageNum);
%>
