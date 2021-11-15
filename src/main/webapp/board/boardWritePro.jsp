<%@page import="java.sql.Timestamp"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.BoardDAO"%>
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

// BoardDAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();

// insert할 새 게시글 번호 가져오기
int num = boardDAO.getNextnum(); // attach 레코드의 bno 컬럼값에 해당함

// BoardVO 객체 준비
BoardVO boardVO = new BoardVO();

// 글번호 설정
boardVO.setNum(num);

// 파라미터값 가져와서 VO에 저장. MultipartRequest 로부터 가져옴.
boardVO.setSubject(multi.getParameter("subject"));
boardVO.setContent(multi.getParameter("content"));
boardVO.setNick(multi.getParameter("nick"));
boardVO.setMid(multi.getParameter("id"));

// regDate  readcount
boardVO.setRegDate(new Timestamp(System.currentTimeMillis()));
boardVO.setReadcount(0); // 조회수

// 주글 등록하기
boardDAO.addBoard(boardVO);

// 요청 페이지번호 파라미터 가져오기
String pageNum = multi.getParameter("pageNum");

// 글상세보기 화면으로 이동
response.sendRedirect("/board/boardView.jsp?num=" + boardVO.getNum() + "&pageNum=" + pageNum);
%>
