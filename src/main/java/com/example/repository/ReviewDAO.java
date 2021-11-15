package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.ReviewVO;
import com.example.domain.Criteria;

public class ReviewDAO {

	private static ReviewDAO instance;

	public static ReviewDAO getInstance() {
		if (instance == null) {
			instance = new ReviewDAO();
		}
		return instance;
	}

	private ReviewDAO() {
	}

	// review 테이블 모든 레코드 삭제
	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM review";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteAll

	public void deleteReviewByNum(int rnum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM review WHERE rnum = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteReviewByNum

	// 전체글개수 가져오기
	public int getCountAll() {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT COUNT(*) AS cnt FROM review";

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
			sql += "FROM review ";

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

	// SELECT IFNULL(MAX(rnum), 0) + 1 AS nextrnum FROM review
	public int getNextrnum() {
		int rnum = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT IFNULL(MAX(rnum), 0) + 1 AS nextrnum FROM review";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				rnum = rs.getInt("nextrnum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return rnum;
	} // getNextrnum

	// 글쓰기
	public void addReview(ReviewVO reviewVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "INSERT INTO review (rnum, rsubject, rcontent, rnick, rmid, rreg_date, rreadcount) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, reviewVO.getRnum());
			pstmt.setString(2, reviewVO.getRsubject());
			pstmt.setString(3, reviewVO.getRcontent());
			pstmt.setString(4, reviewVO.getRnick());
			pstmt.setString(5, reviewVO.getRmid());
			pstmt.setTimestamp(6, reviewVO.getRregDate());
			pstmt.setInt(7, reviewVO.getRreadcount());
			// 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // addReview

	public List<ReviewVO> getReviews() {
		List<ReviewVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM review ";
			sql += "ORDER BY rnum DESC ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewVO reviewVO = new ReviewVO();
				reviewVO.setRnum(rs.getInt("rnum"));
				reviewVO.setRsubject(rs.getString("rsubject"));
				reviewVO.setRcontent(rs.getString("rcontent"));
				reviewVO.setRnick(rs.getString("rnick"));
				reviewVO.setRmid(rs.getString("rmid"));
				reviewVO.setRregDate(rs.getTimestamp("rreg_date"));
				reviewVO.setRreadcount(rs.getInt("rreadcount"));

				list.add(reviewVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getReviews

	public List<ReviewVO> getReviews(Criteria cri) {
		List<ReviewVO> list = new ArrayList<>();

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
			sql += "FROM review ";

			if (cri.getType().length() > 0) { // cri.getType().equals("") == false
				sql += "WHERE " + cri.getType() + " LIKE ? ";
			}
			sql += "ORDER BY rnum DESC ";
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
				ReviewVO reviewVO = new ReviewVO();
				reviewVO.setRnum(rs.getInt("rnum"));
				reviewVO.setRsubject(rs.getString("rsubject"));
				reviewVO.setRcontent(rs.getString("rcontent"));
				reviewVO.setRnick(rs.getString("rnick"));
				reviewVO.setRmid(rs.getString("rmid"));
				reviewVO.setRregDate(rs.getTimestamp("rreg_date"));
				reviewVO.setRreadcount(rs.getInt("rreadcount"));

				list.add(reviewVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getReviews

	public ReviewVO getReview(int rnum) {
		ReviewVO reviewVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM review ";
			sql += "WHERE rnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				reviewVO = new ReviewVO();
				reviewVO.setRnum(rs.getInt("rnum"));
				reviewVO.setRsubject(rs.getString("rsubject"));
				reviewVO.setRcontent(rs.getString("rcontent"));
				reviewVO.setRnick(rs.getString("rnick"));
				reviewVO.setRmid(rs.getString("rmid"));
				reviewVO.setRregDate(rs.getTimestamp("rreg_date"));
				reviewVO.setRreadcount(rs.getInt("rreadcount"));
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return reviewVO;
	} // getReview

	// 조회수 1 증가시키는 메소드
	public void updateReadcount(int rnum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE review ";
			sql += "SET hreadcount = hreadcount + 1 ";
			sql += "WHERE rnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateReadcount

	// 게시글 수정하기
	public void updateReview(ReviewVO reviewVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE review ";
			sql += "SET hsubject = ?, hcontent = ? ";
			sql += "WHERE rnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewVO.getRsubject());
			pstmt.setString(2, reviewVO.getRcontent());
			pstmt.setInt(3, reviewVO.getRnum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateReview

}
