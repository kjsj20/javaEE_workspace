package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import db.DBManager;

public class ImageBoardDAO {
	DBManager dbManager = new DBManager(); //ImagesBoardDAO의 인스턴스가 생성될때
											//DBManager의 인스턴스도 같이 생성됨
	//create 
	public int insert(ImageBoard board) {
		int result = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "insert into imageboard(author,title,content,filename) values(?,?,?,?)";
		con = dbManager.getConnection();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getAuthor());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getContent());
			pstmt.setString(4, board.getFilename());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbManager.release(con, pstmt);
		}
		
		return result;
	}
	//selectAll
//	public ImageBoard selectAll() {
//		String sql = "select * from imageboard";
//		
//	}
//	//select
//	public ImageBoard select() {
//		String sql = "select * from imageboard where board_id = ?";
//		
//	}
	//update
	public int update() {
		int result = 0;
		String sql = "update imageboard set author = ?, title = ?, content = ?, where board_id = ?";
		return 0;
	}
	//delete
	public int delete() {
		int result = 0;
		String sql = "delete from imageboard where board_id";
		return 0;
	}
}
