package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.MemberVO;

public class MemberDAO {

	// 싱글톤 설계
	private static MemberDAO instance;

	public static MemberDAO getInstance() {
		if (instance == null) {
			instance = new MemberDAO();
		}
		return instance;
	}

	private MemberDAO() {
	}
	// 싱글톤 설계 완료

	public int insert(MemberVO memberVO) {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "INSERT INTO member (id, passwd, nickname, birthday, email, reg_date) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?) ";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, memberVO.getId());
			pstmt.setString(2, memberVO.getPasswd());
			pstmt.setString(3, memberVO.getNickname());
			pstmt.setString(4, memberVO.getBirthday());
			pstmt.setString(5, memberVO.getEmail());
			pstmt.setTimestamp(6, memberVO.getRegDate());

			count = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		return count;
	} // insert

	public int deleteAll() {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM member";

			pstmt = con.prepareStatement(sql);

			count = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		return count;
	} // deleteAll

	public int deleteById(String id) {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM member WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			count = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		return count;
	} // deleteById

	public void updateById(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			StringBuilder sb = new StringBuilder();
			sb.append("UPDATE member ");
			sb.append("SET nickname = ?, birthday = ?, email = ?, reg_date = ? ");
			sb.append("WHERE id = ? ");

			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, memberVO.getNickname());
			pstmt.setString(2, memberVO.getBirthday());
			pstmt.setString(3, memberVO.getEmail());
			pstmt.setTimestamp(4, memberVO.getRegDate());
			pstmt.setString(5, memberVO.getId());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateById

	public int getCountById(String id) {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT count(*) AS cnt FROM member WHERE id = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountById
	
	public int getCountByNickname(String nickname) {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "SELECT count(*) AS cnt FROM member WHERE nickname = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickname);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountByNickname

	public int getCountAll() {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT count(*) AS cnt FROM member";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountAll

	public MemberVO getMemberById(String id) {
		MemberVO memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT * FROM member WHERE id = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString("id"));
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setNickname(rs.getString("nickname"));
				memberVO.setBirthday(rs.getString("birthday"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setRegDate(rs.getTimestamp("reg_date"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return memberVO;
	} // getMemberById

	public List<MemberVO> getMembers() {
		List<MemberVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT * FROM member ORDER BY id";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberVO memberVO = new MemberVO();
				memberVO.setId(rs.getString("id"));
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setNickname(rs.getString("nickname"));
				memberVO.setBirthday(rs.getString("birthday"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setRegDate(rs.getTimestamp("reg_date"));

				list.add(memberVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getMembers

}
