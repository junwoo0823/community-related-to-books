<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// num  pageNum   파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// DAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();

// DB 게시글 정보 삭제하기
boardDAO.deleteBoardByNum(num);

// 글목록 boardList.jsp로 이동
response.sendRedirect("/board/boardList.jsp?pageNum=" + pageNum);
%>
