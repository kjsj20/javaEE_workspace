/*
 * DAO란 ?
 * - Data Access Object를 의미하는 어플리케이션의 설계 분야 용어
 * - Data Access란 데이터베이스와의 CRUD작업을 전담한다는 의미
 * */
package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.DBManager;

public class NoticeDAO {
	DBManager dbManager = new DBManager();
	
	public int regist(Notice notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result= 0;
		con = dbManager.getConnection();
		
		String sql = "insert into notice(author, title, content) values(?,?,?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, notice.getAuthor());
			pstmt.setString(2, notice.getTitle());
			pstmt.setString(3, notice.getContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbManager.release(con, pstmt);
		}
		
		return result;
	}
	
	//모든 레코드 가져오기 !!
	public ArrayList<Notice> selectAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Notice> list = new ArrayList<Notice>();
		con = dbManager.getConnection();
		String sql = "select * from notice order by notice_id desc";
		try {
			pstmt = con.prepareStatement(sql);
			rs= pstmt.executeQuery();
			while(rs.next()) {
				Notice notice = new Notice();
				notice = new Notice();//텅빈 empty상태의 vo 생성
				notice.setNotice_id(rs.getInt("notice_id"));
				notice.setAuthor(rs.getString("author"));
				notice.setTitle(rs.getString("title"));
				notice.setContent(rs.getString("content"));
				notice.setRegdate(rs.getString("regdate"));
				notice.setHit(rs.getInt("hit"));
				list.add(notice);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbManager.release(con, pstmt, rs);
		}
		return list;
	}
	
	//게시물 1건 가져오기(상세보기)
	public Notice select(int notice_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Notice notice=null; //rs대신 데이터 1건을 담을 객체
		
		String sql = "select * from notice where notice_id = ?";
		
		con = dbManager.getConnection();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice_id);
			rs = pstmt.executeQuery();
			
			//지금 탄생한 rs는 곧 죽는다.. 따라서 rs를 대체할 객체가 필요하다!!
			//rs는 레코드 한건을 담는 객체이므로, 레코드 1건을 담아 전달용으로 사용되는 VO를 이용하자!!
			if(rs.next()) {
				notice = new Notice();//텅빈 empty상태의 vo 생성
				notice.setNotice_id(rs.getInt("notice_id"));
				notice.setAuthor(rs.getString("author"));
				notice.setTitle(rs.getString("title"));
				notice.setContent(rs.getString("content"));
				notice.setRegdate(rs.getString("regdate"));
				notice.setHit(rs.getInt("hit"));
			} else {
				System.out.println("조회 오류");
			}
			
			sql = "update notice set hit = hit+1 where notice_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice_id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbManager.release(con, pstmt, rs);
		}
		return notice;
	}
	
	//게시물 1건 수정
	public int update(Notice notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "update notice set author = ?, title = ?, content = ? where notice_id = ?";
		
		con = dbManager.getConnection();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, notice.getAuthor());
			pstmt.setString(2, notice.getTitle());
			pstmt.setString(3, notice.getContent());
			pstmt.setInt(4, notice.getNotice_id());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbManager.release(con, pstmt);
		}
		
		return result;
		
	}
	
	//게시물 1건 삭제
		public int delete(int notice_id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int result = 0;
			String sql = "delete from notice where notice_id = ?";
			
			con = dbManager.getConnection();
			
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, notice_id);
				result = pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dbManager.release(con, pstmt);
			}
			
			return result;
			
		}
}
