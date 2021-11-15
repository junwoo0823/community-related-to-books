<%@page import="java.sql.Timestamp"%>
<%@page import="com.example.domain.NoticeVO"%>
<%@page import="com.example.repository.NoticeDAO"%>
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

// NoticeDAO 객체 준비
NoticeDAO noticeDAO = NoticeDAO.getInstance();

// insert할 새 게시글 번호 가져오기
int num = noticeDAO.getNextnnum(); // attach 레코드의 bno 컬럼값에 해당함

// NoticeVO 객체 준비
NoticeVO noticeVO = new NoticeVO();

// 글번호 설정
noticeVO.setNnum(num);

// 파라미터값 가져와서 VO에 저장. MultipartRequest 로부터 가져옴.
noticeVO.setNsubject(multi.getParameter("subject"));
noticeVO.setNcontent(multi.getParameter("content"));
noticeVO.setNnick(multi.getParameter("nick"));
noticeVO.setNmid(multi.getParameter("id"));

// regDate  readcount
noticeVO.setNregDate(new Timestamp(System.currentTimeMillis()));
noticeVO.setNreadcount(0); // 조회수

// 주글 등록하기
noticeDAO.addNotice(noticeVO);

// 요청 페이지번호 파라미터 가져오기
String pageNum = multi.getParameter("pageNum");

// 글상세보기 화면으로 이동
response.sendRedirect("/notice/noticeView.jsp?num=" + noticeVO.getNnum() + "&pageNum=" + pageNum);
%>
