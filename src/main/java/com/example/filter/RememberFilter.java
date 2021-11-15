package com.example.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class RememberFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;

		HttpSession session = req.getSession();

		String id = (String) session.getAttribute("id");

		if (id == null) {
			// 쿠키 배열객체 가져오기
			Cookie[] cookies = req.getCookies();

			// 로그인 상태유지용 쿠키정보를 찾기
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("loginId")) {
						id = cookie.getValue();

						// 세션에 저장 (로그인 인증 처리)
						session.setAttribute("id", id);
					}
				} // for
			}
		} // if

		chain.doFilter(request, response);

	} // doFilter

}
