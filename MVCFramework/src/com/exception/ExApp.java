package com.exception;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ExApp {
	//throws 는 현재 메서드에서 해당 예외를 처리하지 않고, 이 메서드를 호출한 자에게 떠넘기는것!!!
	public void insert() throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
	}
	
	public static void main(String[] args) throws SQLException{
		ExApp app = new ExApp();
		app.insert();
	}
}
