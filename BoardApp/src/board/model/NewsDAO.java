package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class NewsDAO {
	
	DBManager dbManager = new DBManager();
	List<News> list = new ArrayList<News>();
	public List selectAll() {
		String sql = "select * from news order by news_id desc";
		StringBuilder sb = new StringBuilder();
		sb.append("select n.news_id as news_id,n.title as title, writer, regdate, hit, count(c.comments_id) as cnt");
		sb.append(" from news n left outer join comments c");
		sb.append(" on n.news_id = c.news_id");
		sb.append(" group by n.news_id, n.title, writer, regdate, hit");
		sb.append(" order by n.news_id desc");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		con = dbManager.getConnection();
		
		try {
			pstmt = con.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				News news = new News();
				news.setNews_id(rs.getInt("news_id"));
				news.setTitle(rs.getString("title"));
				news.setWriter(rs.getString("writer"));
				news.setRegdate(rs.getString("regdate"));
				news.setHit(rs.getInt("hit"));
				news.setCnt(rs.getInt("cnt"));
				list.add(news);
				
				con.commit();
			};
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			dbManager.release(con, pstmt, rs);
		}
		
		return list;
	}
	
	public News select(int news_id) {
		String sql = "select * from news where news_id = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		con = dbManager.getConnection();
		News news = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, news_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				news = new News();
				
				news.setNews_id(rs.getInt("news_id"));
				news.setTitle(rs.getString("title"));
				news.setWriter(rs.getString("writer"));
				news.setContent(rs.getString("content"));
				news.setRegdate(rs.getString("regdate"));
				news.setHit(rs.getInt("hit"));
				
				con.commit();
			}
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally {
			dbManager.release(con, pstmt, rs);
		}
		
		return news;
	}
	
	public int insert(News news) {
		int result = 0;
		String sql = "insert into news(title, writer, content) values(?,?,?)";
		PreparedStatement pstmt = null;
		Connection con = null;
		con = dbManager.getConnection();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, news.getTitle());
			pstmt.setString(2, news.getWriter());
			pstmt.setString(3, news.getContent());
			
			result = pstmt.executeUpdate();
			
			con.commit();
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			dbManager.release(con, pstmt);
		}
		
		return result;
	}
	
	public int update(News news) {
		int result = 0;
		
		String sql = "update news set title = ?, writer = ?, content = ? where news_id = ?";
		PreparedStatement pstmt = null;
		Connection con = null;
		con = dbManager.getConnection();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, news.getTitle());
			pstmt.setString(2, news.getWriter());
			pstmt.setString(3, news.getContent());
			pstmt.setInt(4, news.getNews_id());
			
			result = pstmt.executeUpdate();
			
			con.commit();
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			dbManager.release(con, pstmt);
		}
		
		return result;
	}
	
	public int delete(int news_id) {
		int result = 0;
		
		String sql = "delete from news where news_id = ?";
		PreparedStatement pstmt = null;
		Connection con = null;
		con = dbManager.getConnection();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, news_id);
			result = pstmt.executeUpdate();
			
			con.commit();
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			dbManager.release(con, pstmt);
		}
		return result;
	}
	
	//게시물 지우지 않고, 삭제된 게시물이라는 표시 처리
	public int replace(int news_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "update news set title = '작성자에 의해 삭제된 게시물 입니다', writer = '', content = '' where news_id = ?";
		
		con = dbManager.getConnection();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, news_id);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbManager.release(con, pstmt);
		}
	
		return result;
	}
}
