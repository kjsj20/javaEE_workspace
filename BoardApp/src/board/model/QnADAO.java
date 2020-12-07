package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class QnADAO {
	
	QnA qna = new QnA();
	DBManager dbManager = new DBManager();
	//insert
	public int insert(QnA qna) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		String sql = "insert into qna(writer, title, content) values(?,?,?)";
		
		con= dbManager.getConnection();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1 , qna.getWriter());
			pstmt.setString(2 , qna.getTitle());
			pstmt.setString(3 , qna.getContent());
			result = pstmt.executeUpdate();
			
			sql = "update qna set team=(select last_insert_id()) where qna_id = (select last_insert_id())";
			pstmt = con.prepareStatement(sql);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbManager.release(con, pstmt);
		}
		
		return result;
	}
	
	//답변글
	public int reply() {
		int result = 0;
		return result;
	}
	//selectAll
	public List selectAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<QnA> list = new ArrayList<QnA>();
		
		String sql = "select * from qna order by team asc, rank asc";
		con = dbManager.getConnection();
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnA qna = new QnA();
				qna.setQna_id(rs.getInt("qna_id"));
				qna.setWriter(rs.getString("writer"));
				qna.setTitle(rs.getString("title"));
				qna.setContent(rs.getString("content"));
				qna.setRegdate(rs.getString("regdate"));
				qna.setTeam(rs.getInt("team"));
				qna.setRank(rs.getInt("rank"));
				qna.setDepth(rs.getInt("depth"));
				
				list.add(qna);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dbManager.release(con, pstmt, rs);
		}
		return list;
	}
	//select
	public QnA select(int qna_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnA qna = null;
		
		String sql = "select * from qna where qna_id = ?";
		con = dbManager.getConnection();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qna_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				qna = new QnA();
				qna.setQna_id(rs.getInt("qna_id"));
				qna.setWriter(rs.getString("writer"));
				qna.setTitle(rs.getString("title"));
				qna.setContent(rs.getString("content"));
				qna.setRegdate(rs.getString("regdate"));
				qna.setTeam(rs.getInt("team"));
				qna.setRank(rs.getInt("rank"));
				qna.setDepth(rs.getInt("depth"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbManager.release(con, pstmt, rs);
		}
		return qna;
	}
	//update
	public int update() {
		int result = 0;
		return result;
	}
	//delete
	public int delete() {
		int result = 0;
		return result;
	}
}
