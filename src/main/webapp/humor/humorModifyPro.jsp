<%@page import="java.sql.Timestamp"%>
<%@page import="com.example.domain.HumorVO"%>
<%@page import="com.example.repository.HumorDAO"%>
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

// HumorDAO 객체 준비
HumorDAO humorDAO = HumorDAO.getInstance();

//수정할 게시글 번호 파라미터 가져오기
int num = Integer.parseInt(multi.getParameter("num"));

// HumorVO 객체 준비
HumorVO humorVO = new HumorVO();

// 파라미터값 가져와서 VO에 저장
humorVO.setHnum(num);
humorVO.setHsubject(multi.getParameter("subject"));
humorVO.setHcontent(multi.getParameter("content"));
humorVO.setHnick(multi.getParameter("nick"));
humorVO.setHmid(multi.getParameter("id"));

// 게시글 수정하기
humorDAO.updateHumor(humorVO);

// 요청 페이지번호 파라미터 가져오기
String pageNum = multi.getParameter("pageNum");
%>
<script>
	location.href = '/humor/humorView.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
</script>