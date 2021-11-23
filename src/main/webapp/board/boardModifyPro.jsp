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
MultipartRequest multi = new MultipartRequest(request, uploadPath.getPath(), 1024 * 1024 * 50, "utf-8",
		new DefaultFileRenamePolicy());

// BoardDAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();

//수정할 게시글 번호 파라미터 가져오기
int num = Integer.parseInt(multi.getParameter("num"));

// BoardVO 객체 준비
BoardVO boardVO = new BoardVO();

// 파라미터값 가져와서 VO에 저장
boardVO.setNum(num);
boardVO.setSubject(multi.getParameter("subject"));
boardVO.setContent(multi.getParameter("content"));
boardVO.setNick(multi.getParameter("nick"));
boardVO.setMid(multi.getParameter("id"));

// 게시글 수정하기
boardDAO.updateBoard(boardVO);

// 요청 페이지번호 파라미터 가져오기
String pageNum = multi.getParameter("pageNum");
%>
<script>
	location.href = '/board/boardView.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
</script>