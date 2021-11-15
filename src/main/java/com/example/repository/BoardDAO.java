package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;

public class BoardDAO {

	private static BoardDAO instance;

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	private BoardDAO() {
	}

	// board 테이블 모든 레코드 삭제
	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM board";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteAll

	public void deleteBoardByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM board WHERE num = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteBoardByNum

	// 전체글개수 가져오기
	public int getCountAll() {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT COUNT(*) AS cnt FROM board";

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
			sql += "FROM board ";

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

	// SELECT IFNULL(MAX(num), 0) + 1 AS nextnum FROM board
	public int getNextnum() {
		int num = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT IFNULL(MAX(num), 0) + 1 AS nextnum FROM board";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt("nextnum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return num;
	} // getNextnum

	// 글쓰기
	public void addBoard(BoardVO boardVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "INSERT INTO board (num, subject, content, nick, mid, reg_date, readcount) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, boardVO.getNum());
			pstmt.setString(2, boardVO.getSubject());
			pstmt.setString(3, boardVO.getContent());
			pstmt.setString(4, boardVO.getNick());
			pstmt.setString(5, boardVO.getMid());
			pstmt.setTimestamp(6, boardVO.getRegDate());
			pstmt.setInt(7, boardVO.getReadcount());
			// 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // addBoard

	public List<BoardVO> getBoards() {
		List<BoardVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM board ";
			sql += "ORDER BY num DESC ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setNum(rs.getInt("num"));
				boardVO.setSubject(rs.getString("subject"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setNick(rs.getString("nick"));
				boardVO.setMid(rs.getString("mid"));
				boardVO.setRegDate(rs.getTimestamp("reg_date"));
				boardVO.setReadcount(rs.getInt("readcount"));

				list.add(boardVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getBoards

	public List<BoardVO> getBoards(Criteria cri) {
		List<BoardVO> list = new ArrayList<>();

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
			sql += "FROM board ";

			if (cri.getType().length() > 0) { // cri.getType().equals("") == false
				sql += "WHERE " + cri.getType() + " LIKE ? ";
			}
			sql += "ORDER BY num DESC ";
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
				BoardVO boardVO = new BoardVO();
				boardVO.setNum(rs.getInt("num"));
				boardVO.setSubject(rs.getString("subject"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setNick(rs.getString("nick"));
				boardVO.setMid(rs.getString("mid"));
				boardVO.setRegDate(rs.getTimestamp("reg_date"));
				boardVO.setReadcount(rs.getInt("readcount"));

				list.add(boardVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getBoards

	public BoardVO getBoard(int num) {
		BoardVO boardVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM board ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				boardVO = new BoardVO();
				boardVO.setNum(rs.getInt("num"));
				boardVO.setSubject(rs.getString("subject"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setNick(rs.getString("nick"));
				boardVO.setMid(rs.getString("mid"));
				boardVO.setRegDate(rs.getTimestamp("reg_date"));
				boardVO.setReadcount(rs.getInt("readcount"));
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return boardVO;
	} // getBoard

	// 조회수 1 증가시키는 메소드
	public void updateReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE board ";
			sql += "SET readcount = readcount + 1 ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateReadcount

	// 게시글 수정하기
	public void updateBoard(BoardVO boardVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE board ";
			sql += "SET subject = ?, content = ? ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardVO.getSubject());
			pstmt.setString(2, boardVO.getContent());
			pstmt.setInt(3, boardVO.getNum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateBoard
	
}
