<%@page import="com.example.repository.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// num  pageNum   파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// DAO 객체 준비
NoticeDAO noticeDAO = NoticeDAO.getInstance();

// DB 게시글 정보 삭제하기
noticeDAO.deleteNoticeByNum(num);

// 글목록 noticeList.jsp로 이동
response.sendRedirect("/notice/noticeList.jsp?pageNum=" + pageNum);
%>
