<%@page import="com.example.repository.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// num  pageNum   파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// DAO 객체 준비
ReviewDAO reviewDAO = ReviewDAO.getInstance();

// DB 게시글 정보 삭제하기
reviewDAO.deleteReviewByNum(num);

// 글목록 reviewList.jsp로 이동
response.sendRedirect("/review/reviewList.jsp?pageNum=" + pageNum);
%>
