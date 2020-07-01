package com.dao;

import static com.db.JDBCTemplate.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.dto.MyDto;

//DataBase와 연동하는 메소드
public class MyDao {
	
	//DB와 연결하여 DB안에 있는 모든 데이터들을 출력하는 메소드
	public List<MyDto> selectList(){
		Connection con = getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		List<MyDto> list = new ArrayList<MyDto>();
		
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT, MYDATE FROM BOARDTEST ORDER BY MYNO DESC ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				MyDto dto = new MyDto(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getDate(5)
						);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	
	//WHERE문으로 조건을 줘서 하나의 값(하나의 ROW = dto)만 가져오는 메소드
	public MyDto selectOne(int myno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MyDto dto = new MyDto();
		
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT FROM BOARDTEST WHERE MYNO = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, myno);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				dto.setMyno(rs.getInt(1));
				dto.setMyname(rs.getString(2));
				dto.setMytitle(rs.getString(3));
				dto.setMycontent(rs.getString(4));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
		}
		return dto;
	}
	
	//DB에 값을 넣어주는 메소드
	public int insert(MyDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " INSERT INTO BOARDTEST VALUES(NEXT.NEXTVAL, ?, ?, ?, SYSDATE) ";
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getMyname());
			pstm.setString(2, dto.getMytitle());
			pstm.setString(3, dto.getMycontent());
			
			res = pstm.executeUpdate();
			
			if(res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		return res;
	}
	
	//가져온 값을 수정하는 메소드
	public int update(MyDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE BOARDTEST SET MYTITLE = ?, MYCONTENT = ? WHERE MYNO = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getMytitle());
			pstm.setString(2, dto.getMycontent());
			pstm.setInt(3, dto.getMyno());
			
			res = pstm.executeUpdate();
			
			if(res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		return res;
	}
	
	//WHERE문으로 조건을 줘서 지정한 값을 삭제하는 메소드
	public int delete(int myno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		String sql = " DELETE FROM BOARDTEST WHERE MYNO = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, myno);
			res = pstm.executeUpdate();
			
			if(res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		return res;
	}

}
