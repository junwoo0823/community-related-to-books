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
MultipartRequest multi = new MultipartRequest(request, uploadPath.getPath(), 1024 * 1024 * 50, "utf-8",
		new DefaultFileRenamePolicy());

// NoticeDAO 객체 준비
NoticeDAO noticeDAO = NoticeDAO.getInstance();

//수정할 게시글 번호 파라미터 가져오기
int num = Integer.parseInt(multi.getParameter("num"));

// NoticeVO 객체 준비
NoticeVO noticeVO = new NoticeVO();

// 파라미터값 가져와서 VO에 저장
noticeVO.setNnum(num);
noticeVO.setNsubject(multi.getParameter("subject"));
noticeVO.setNcontent(multi.getParameter("content"));
noticeVO.setNnick(multi.getParameter("nick"));
noticeVO.setNmid(multi.getParameter("id"));

// 게시글 수정하기
noticeDAO.updateNotice(noticeVO);

// 요청 페이지번호 파라미터 가져오기
String pageNum = multi.getParameter("pageNum");
%>
<script>
	location.href = '/notice/noticeView.jsp.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
</script>