package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//JDBCTemplate는 드라이버 연결 계정연결 db종료를 도와주는 역할이다.
public class JDBCTemplate {
	
	public static Connection getConnection() {
		
		try {
			//1. 드라이버를 연결해준다.
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		//url과 계정, 비밀번호를 입력한다.
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "kh";
		String pw = "kh";
		
		//con의 객체를 생성한다.
		Connection con = null;
		
		try {
			//2. 계정을 연결해준다.
			con = DriverManager.getConnection(url, user, pw);
			//setAutoCommit는 자동으로 commit되는 기능인데.
			//나는 commit을 내 마음대로 원할 때에 해주기 위해 false를 넣었다.
			con.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;	
	}
	
	//여기서부터 con과 stmt, rs를 close해주는 메소드와
	//con을 commit, rollback하는 메소드를 만들어야 한다.
	public static void close(Connection con) {
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void close(Statement stmt) {
		try {
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs) {
		try {
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void commit(Connection con) {
		try {
			con.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void rollback(Connection con) {
		try {
			con.rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
