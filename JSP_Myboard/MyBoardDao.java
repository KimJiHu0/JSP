package com.my.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.my.dto.MyBoardDto;

public class MyBoardDao {
	
	//전체출력
	public List<MyBoardDto> selectList(){
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1.드라이버 연결");
		} catch (ClassNotFoundException e) {
			System.out.println("[error] 1.");
			e.printStackTrace();
		}
		
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "kh";
		String password = "kh";
		
		Connection con = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			//commit을 내 마음대로 하기 위해서 자동커밋이아니라 원하는 상황에서
			//commit메소드를 불러와서 commit하기 위해
			con.setAutoCommit(false);
			System.out.println("2. 계정연결");
		} catch (SQLException e) {
			System.out.println("[error] 2.");
			e.printStackTrace();
		}
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT, MYDATE "
				     + " FROM MYBOARD ORDER BY MYNO DESC ";
		
		List<MyBoardDto> list = new ArrayList<MyBoardDto>();
		
		try {
			stmt = con.createStatement();
			System.out.println("3. query 준비 : " + sql);
			
			//4.실행해서 리턴
			
			rs = stmt.executeQuery(sql);
			System.out.println("4. query 실행 및 리턴");
			
			while(rs.next()) {
				MyBoardDto dto = new MyBoardDto();
				dto.setMyno(rs.getInt(1));
				dto.setMyname(rs.getString("MyName"));
				dto.setMytitle(rs.getString(3));
				dto.setMycontent(rs.getString(4));
				dto.setMydate(rs.getDate(5));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("[error] 3 or 4");
			e.printStackTrace();
		} finally {
			//5,db종료
			try {
				rs.close();
				stmt.close();
				con.close();
				System.out.println("5. db종료");
			} catch (SQLException e) {
				System.out.println("[error] 5.");
				e.printStackTrace();
			}
			
		}
		
		
		
		return list;
	}
	
	//선택출력
	public MyBoardDto selectOne(int myno) {
		//드라이버연결
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1.드라이버 연결");
		} catch (ClassNotFoundException e) {
			System.out.println("[error] 1.");
			e.printStackTrace();
		}
		
		//계정연결
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "kh";
		String password = "kh";
		
		Connection con = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			//commit을 내 마음대로 하기 위해서 자동커밋이아니라 원하는 상황에서
			//commit메소드를 불러와서 commit하기 위해
			con.setAutoCommit(false);
			System.out.println("2. 계정연결");
		} catch (SQLException e) {
			System.out.println("[error] 2.");
			e.printStackTrace();
		}
		
		//쿼리준비
		
		PreparedStatement pstm = null;
		//테이블의 ROW를..
		ResultSet rs = null;
		
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT, MYDATE "
				+ " FROM MYBOARD WHERE MYNO = ?";
		
		//실행 결과물을 dto에 담기 위해 작성.
		MyBoardDto dto = new MyBoardDto();
		
		try {
			pstm = con.prepareStatement(sql);
			//pstm에 sql구문을 담고
			pstm.setInt(1, myno);
			//pstm의 ? 에 값을 담아준다.
			System.out.println("3.query 준비.");
			
			//실행 및 리턴
			rs = pstm.executeQuery();
			//pstm이 실행한 결과를 rs에 담는다.
			
			while(rs.next()) {
				//우리가 만든 dto에 값 넣기.
				dto.setMyno(rs.getInt(1));
				dto.setMyname(rs.getString(2));
				dto.setMytitle(rs.getString(3));
				dto.setMycontent(rs.getString(4));
				dto.setMydate(rs.getDate(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstm.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	//추가
	public int insert(MyBoardDto dto) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1.드라이버 연결");
		} catch (ClassNotFoundException e) {
			System.out.println("[error] 1.");
			e.printStackTrace();
		}
		
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "kh";
		String password = "kh";
		
		Connection con = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			//commit을 내 마음대로 하기 위해서 자동커밋이아니라 원하는 상황에서
			//commit메소드를 불러와서 commit하기 위해
			con.setAutoCommit(false);
			System.out.println("2. 계정연결");
		} catch (SQLException e) {
			System.out.println("[error] 2.");
			e.printStackTrace();
		}
		
		PreparedStatement pstm = null;
		
		String sql = " INSERT INTO MYBOARD VALUES ( MYSEQ.NEXTVAL , ?, ?, ?, SYSDATE ) ";
		
		//실행한 갯수를 담을 res를 만든다.
		int res = 0;
		
		try {
			pstm = con.prepareStatement(sql);
		
			pstm.setString(1, dto.getMyname());
			pstm.setString(2, dto.getMytitle());
			pstm.setString(3, dto.getMycontent());
			
			//insert update delete할때는 아래처럼 사용, select할 때에는 executeQuery() 사용.
			res = pstm.executeUpdate();
			if(res > 0) {
				con.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstm.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return res;
	}
	
	//수정
	public int update(MyBoardDto dt) {
		try {
			//드라이버연결
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1.드라이버 연결");
		} catch (ClassNotFoundException e) {
			System.out.println("[error] 1.");
			e.printStackTrace();
		}
		
		//계정연결
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "kh";
		String password = "kh";
		
		Connection con = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			//commit을 내 마음대로 하기 위해서 자동커밋이아니라 원하는 상황에서
			//commit메소드를 불러와서 commit하기 위해
			con.setAutoCommit(false);
			System.out.println("2. 계정연결");
		} catch (SQLException e) {
			System.out.println("[error] 2.");
			e.printStackTrace();
		}
		
		//쿼리준비
		PreparedStatement pstm = null;
		
		int res = 0;
		
		String sql = " UPDATE MYBOARD SET MYTITLE = ?, MYCONTENT = ? WHERE MYNO = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setString(1, dt.getMytitle());
			pstm.setString(2, dt.getMycontent());
			pstm.setInt(3, dt.getMyno());
			
			//쿼리실행 및 리턴
			res = pstm.executeUpdate();
			if(res > 0) {
				con.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				//db종료
				pstm.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return res;
	}
	
	//삭제
	public int delete(int myno) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "kh";
		String password = "kh";
		
		Connection con = null;
		
		try {
			con = DriverManager.getConnection(url, user, password);
			con.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		PreparedStatement pstm = null;
		
		String sql = " DELETE FROM MYBOARD WHERE MYNO = ? ";
		
		int res = 0;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, myno);
			
			res = pstm.executeUpdate();
			if(res > 0) {
				con.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstm.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return res;
	}
}
