package db;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class DBManager{
	String driver = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost:3306/db1202";
	String user = "root";
	String password ="1234";

	//접속객체 얻기
	public Connection getConnection(){
		Connection con = null;
		try{
			Class.forName(driver); //드라이버 로드!!
			System.out.println("드라이버 로드 성공!");
			//접속시도
			con = DriverManager.getConnection(url,user,password);
		} catch(ClassNotFoundException e){
			e.printStackTrace();
			System.out.println("드라이버를 로드 할 수 없네요..");
		} catch(SQLException e){
			e.printStackTrace();
		}
		return con;
	}

	public void release(Connection con){
		if(con != null){
			try{
				con.close();
			} catch(SQLException e){
				
			}
		}
	}
	
	public void release(Connection con, PreparedStatement pstmt){
		if(pstmt != null){
			try{
				pstmt.close();
			} catch(SQLException e){
				e.printStackTrace();
			}
		} else if(con != null){
			try{
				con.close();
			} catch(SQLException e){
				e.printStackTrace();
			}
		}
	}

	public void release(Connection con, PreparedStatement pstmt, ResultSet rs){
		if(rs != null){
			try{
				rs.close();
			} catch(SQLException e){
				e.printStackTrace();
			}
		} else if(pstmt != null){
			try{
				pstmt.close();
			} catch(SQLException e){
				e.printStackTrace();
			}
		} else if(con != null){
			try{
				con.close();
			} catch(SQLException e){
				e.printStackTrace();
			}
		}
	}
}
