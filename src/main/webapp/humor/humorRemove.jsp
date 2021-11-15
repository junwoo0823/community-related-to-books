<%@page import="com.example.repository.HumorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// num  pageNum   파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// DAO 객체 준비
HumorDAO humorDAO = HumorDAO.getInstance();

// DB 게시글 정보 삭제하기
humorDAO.deleteHumorByNum(num);

// 글목록 humorList.jsp로 이동
response.sendRedirect("/humor/humorList.jsp?pageNum=" + pageNum);
%>
