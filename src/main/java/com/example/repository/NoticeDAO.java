package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.NoticeVO;

public class NoticeDAO {

	private static NoticeDAO instance;

	public static NoticeDAO getInstance() {
		if (instance == null) {
			instance = new NoticeDAO();
		}
		return instance;
	}

	private NoticeDAO() {
	}

	// notice 테이블 모든 레코드 삭제
	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM notice";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteAll

	public void deleteNoticeByNum(int nnum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM notice WHERE nnum = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, nnum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteNoticeByNum

	// 전체글개수 가져오기
	public int getCountAll() {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT COUNT(*) AS cnt FROM notice";

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
			sql += "FROM notice ";

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

	// SELECT IFNULL(MAX(nnum), 0) + 1 AS nextnnum FROM notice
	public int getNextnnum() {
		int nnum = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT IFNULL(MAX(nnum), 0) + 1 AS nextnnum FROM notice";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				nnum = rs.getInt("nextnnum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return nnum;
	} // getNextnnum

	// 글쓰기
	public void addNotice(NoticeVO noticeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "INSERT INTO notice (nnum, nsubject, ncontent, nnick, nmid, nreg_date, nreadcount) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, noticeVO.getNnum());
			pstmt.setString(2, noticeVO.getNsubject());
			pstmt.setString(3, noticeVO.getNcontent());
			pstmt.setString(4, noticeVO.getNnick());
			pstmt.setString(5, noticeVO.getNmid());
			pstmt.setTimestamp(6, noticeVO.getNregDate());
			pstmt.setInt(7, noticeVO.getNreadcount());
			// 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // addNotice

	public List<NoticeVO> getNotices() {
		List<NoticeVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM notice ";
			sql += "ORDER BY nnum DESC ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeVO noticeVO = new NoticeVO();
				noticeVO.setNnum(rs.getInt("nnum"));
				noticeVO.setNsubject(rs.getString("nsubject"));
				noticeVO.setNcontent(rs.getString("ncontent"));
				noticeVO.setNnick(rs.getString("nnick"));
				noticeVO.setNmid(rs.getString("nmid"));
				noticeVO.setNregDate(rs.getTimestamp("nreg_date"));
				noticeVO.setNreadcount(rs.getInt("nreadcount"));

				list.add(noticeVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getNotices

	public List<NoticeVO> getNotices(Criteria cri) {
		List<NoticeVO> list = new ArrayList<>();

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
			sql += "FROM notice ";

			if (cri.getType().length() > 0) { // cri.getType().equals("") == false
				sql += "WHERE " + cri.getType() + " LIKE ? ";
			}
			sql += "ORDER BY nnum DESC ";
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
				NoticeVO noticeVO = new NoticeVO();
				noticeVO.setNnum(rs.getInt("nnum"));
				noticeVO.setNsubject(rs.getString("nsubject"));
				noticeVO.setNcontent(rs.getString("ncontent"));
				noticeVO.setNnick(rs.getString("nnick"));
				noticeVO.setNmid(rs.getString("nmid"));
				noticeVO.setNregDate(rs.getTimestamp("nreg_date"));
				noticeVO.setNreadcount(rs.getInt("nreadcount"));

				list.add(noticeVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getNotices

	public NoticeVO getNotice(int nnum) {
		NoticeVO noticeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM notice ";
			sql += "WHERE nnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, nnum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				noticeVO = new NoticeVO();
				noticeVO.setNnum(rs.getInt("nnum"));
				noticeVO.setNsubject(rs.getString("nsubject"));
				noticeVO.setNcontent(rs.getString("ncontent"));
				noticeVO.setNnick(rs.getString("nnick"));
				noticeVO.setNmid(rs.getString("nmid"));
				noticeVO.setNregDate(rs.getTimestamp("nreg_date"));
				noticeVO.setNreadcount(rs.getInt("nreadcount"));
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return noticeVO;
	} // getNotice

	// 조회수 1 증가시키는 메소드
	public void updateReadcount(int nnum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE notice ";
			sql += "SET nreadcount = nreadcount + 1 ";
			sql += "WHERE nnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, nnum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateReadcount

	// 게시글 수정하기
	public void updateNotice(NoticeVO noticeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE notice ";
			sql += "SET nsubject = ?, ncontent = ? ";
			sql += "WHERE nnum = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, noticeVO.getNsubject());
			pstmt.setString(2, noticeVO.getNcontent());
			pstmt.setInt(3, noticeVO.getNnum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateNotice

}
