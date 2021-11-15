package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.HumorVO;
import com.example.domain.Criteria;

public class HumorDAO {

	private static HumorDAO instance;

	public static HumorDAO getInstance() {
		if (instance == null) {
			instance = new HumorDAO();
		}
		return instance;
	}

	private HumorDAO() {
	}

	// humor 테이블 모든 레코드 삭제
	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM humor";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteAll

	public void deleteHumorByNum(int hnum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM humor WHERE hnum = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, hnum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteHumorByNum

	// 전체글개수 가져오기
	public int getCountAll() {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT COUNT(*) AS cnt FROM humor";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountAll

	// 전체글개수 가져오기
	public int getCountBySearch(Criteria cri) {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT COUNT(*) AS cnt ";
			sql += "FROM humor ";

			if (cri.getType().length() > 0) { // 검색어가 있으면
				sql += "WHERE " + cri.getType() + " LIKE ? ";
			}
			pstmt = con.prepareStatement(sql); // 문장객체 준비

			if (cri.getType().length() > 0) { // 검색어가 있으면
				pstmt.setString(1, "%" + cri.getKeyword() + "%");
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountAll

	// SELECT IFNULL(MAX(hnum), 0) + 1 AS nexthnum FROM humor
	public int getNexthnum() {
		int hnum = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT IFNULL(MAX(hnum), 0) + 1 AS nexthnum FROM humor";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				hnum = rs.getInt("nexthnum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return hnum;
	} // getNexthnum

	// 글쓰기
	public void addHumor(HumorVO humorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "INSERT INTO humor (hnum, hsubject, hcontent, hnick, hmid, hreg_date, hreadcount) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, humorVO.getHnum());
			pstmt.setString(2, humorVO.getHsubject());
			pstmt.setString(3, humorVO.getHcontent());
			pstmt.setString(4, humorVO.getHnick());
			pstmt.setString(5, humorVO.getHmid());
			pstmt.setTimestamp(6, humorVO.getHregDate());
			pstmt.setInt(7, humorVO.getHreadcount());
			// 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // addHumor

	public List<HumorVO> getHumors() {
		List<HumorVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM humor ";
			sql += "ORDER BY hnum DESC ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				HumorVO humorVO = new HumorVO();
				humorVO.setHnum(rs.getInt("hnum"));
				humorVO.setHsubject(rs.getString("hsubject"));
				humorVO.setHcontent(rs.getString("hcontent"));
				humorVO.setHnick(rs.getString("hnick"));
				humorVO.setHmid(rs.getString("hmid"));
				humorVO.setHregDate(rs.getTimestamp("hreg_date"));
				humorVO.setHreadcount(rs.getInt("hreadcount"));

				list.add(humorVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getHumors

	public List<HumorVO> getHumors(Criteria cri) {
		List<HumorVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 시작 행번호 (MySQL의 LIMIT절의 시작행번호)

		// 한 페이지당 글개수가 10개씩일때
		// 1 페이지 -> 0
		// 2 페이지 -> 10
		// 3 페이지 -> 20
		// 4 페이지 -> 30
		int startRow = (cri.getPageNum() - 1) * cri.getAmount();

		try {
			con = JdbcUtils.getConnection();

			// 동적 sql문
			String sql = "";
			sql = "SELECT * ";
			sql += "FROM humor ";

			if (cri.getType().length() > 0) { // cri.getType().equals("") == false
				sql += "WHERE " + cri.getType() + " LIKE ? ";
			}
			sql += "ORDER BY hnum DESC ";
			sql += "LIMIT ?, ? ";

			pstmt = con.prepareStatement(sql);

			if (cri.getType().length() > 0) { // cri.getType().equals("") == false
				pstmt.setString(1, "%" + cri.getKeyword() + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, cri.getAmount());
			} else {
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, cri.getAmount());
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				HumorVO humorVO = new HumorVO();
				humorVO.setHnum(rs.getInt("hnum"));
				humorVO.setHsubject(rs.getString("hsubject"));
				humorVO.setHcontent(rs.getString("hcontent"));
				humorVO.setHnick(rs.getString("hnick"));
				humorVO.setHmid(rs.getString("hmid"));
				humorVO.setHregDate(rs.getTimestamp("hreg_date"));
				humorVO.setHreadcount(rs.getInt("hreadcount"));

				list.add(humorVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getHumors

	public HumorVO getHumor(int hnum) {
		HumorVO humorVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM humor ";
			sql += "WHERE hnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, hnum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				humorVO = new HumorVO();
				humorVO.setHnum(rs.getInt("hnum"));
				humorVO.setHsubject(rs.getString("hsubject"));
				humorVO.setHcontent(rs.getString("hcontent"));
				humorVO.setHnick(rs.getString("hnick"));
				humorVO.setHmid(rs.getString("hmid"));
				humorVO.setHregDate(rs.getTimestamp("hreg_date"));
				humorVO.setHreadcount(rs.getInt("hreadcount"));
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return humorVO;
	} // getHumor

	// 조회수 1 증가시키는 메소드
	public void updateReadcount(int hnum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE humor ";
			sql += "SET hreadcount = hreadcount + 1 ";
			sql += "WHERE hnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, hnum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateReadcount

	// 게시글 수정하기
	public void updateHumor(HumorVO humorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE humor ";
			sql += "SET hsubject = ?, hcontent = ? ";
			sql += "WHERE hnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, humorVO.getHsubject());
			pstmt.setString(2, humorVO.getHcontent());
			pstmt.setInt(3, humorVO.getHnum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateHumor

}
