package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JdbcUtils {

	// MySQL DB접속정보
	public static final String url = "jdbc:mysql://localhost:3306/booknowledge?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
	public static final String user = "booknowledge";
	public static final String passwd = "bk0823";

	// DB접속 후 커넥션 객체 가져오는 메소드
	public static Connection getConnection() throws Exception {
		Connection con = null;

		Context context = new InitialContext();
		DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/booknowledge");
		con = ds.getConnection(); // 커넥션풀에서 커넥션 객체 1개 빌려오기
		return con;
	} // getConnection

	public static void close(Connection con, PreparedStatement pstmt) {
		close(con, pstmt, null);
	} // close(con, pstmt)

	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		// JDBC 자원 닫기 (사용의 역순으로 닫음)
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // close(con, pstmt, rs)

}