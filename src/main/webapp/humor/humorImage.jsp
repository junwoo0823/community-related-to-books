<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
JSONObject json = new JSONObject();
JSONArray items = new JSONArray();

// 업로드 경로
String uploadPath = "C:/kjw/upload";

int maxSize = 1024 * 1024 * 50; // 한번에 올릴 수 있는 파일 용량 : 50M로 제한
String fileName = ""; // 파일 이름

MultipartRequest multi = null;

try {

	multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

	Enumeration files = multi.getFileNames();

	while (files.hasMoreElements()) {

		String fileData = (String) files.nextElement();
		fileName = multi.getFilesystemName(fileData);
		File f = multi.getFile(fileData);

		BufferedImage image = ImageIO.read(f);
		int width = image.getWidth();
		int height = image.getHeight();

		JSONObject obj = new JSONObject();
		obj.put("name", fileName);
		obj.put("width", width);
		obj.put("height", height);

		items.add(obj);

	}

	json.put("items", items);

} catch (Exception e) {
	e.printStackTrace();
}

// json add
json.put("resultCode", "000");
json.put("resultMessage", "Success");
json.put("items", items);
response.setContentType("application/json");
out.print(json.toJSONString());
%>