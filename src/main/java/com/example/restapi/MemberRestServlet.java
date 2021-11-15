package com.example.restapi;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.domain.MemberVO;
import com.example.repository.MemberDAO;
import com.example.util.MemberDeserializer;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet("/api/members/*")
public class MemberRestServlet extends HttpServlet {

	private static final String BASE_URI = "/api/members";

	private MemberDAO memberDAO = MemberDAO.getInstance();

	private Gson gson;

	public MemberRestServlet() {
		GsonBuilder builder = new GsonBuilder();
		builder.registerTypeAdapter(MemberVO.class, new MemberDeserializer());
		gson = builder.create();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String requestURI = request.getRequestURI();

		String id = requestURI.substring(BASE_URI.length());

		String strJson = "";
		if (id.length() == 0) {

			List<MemberVO> memberList = memberDAO.getMembers();

			strJson = gson.toJson(memberList);

		} else {
			id = id.substring(1); // 맨앞에 "/" 문자 제거

			MemberVO memberVO = memberDAO.getMemberById(id); // null 리턴할수도 있음
			int count = memberDAO.getCountById(id); // 항상 숫자 리턴함

			Map<String, Object> map = new HashMap<>();
			map.put("member", memberVO);
			map.put("count", count);

			strJson = gson.toJson(map);
		}
		sendResponse(response, strJson);
	} // doGet

	private void sendResponse(HttpServletResponse response, String json) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
	} // sendResponse

}
