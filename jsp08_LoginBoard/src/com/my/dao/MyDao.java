package com.my.dao;

import static com.my.db.JDBCTemplate.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.my.dto.MyDto;

public class MyDao {
	
	//회원 전체출력 : Admin(관리자)
	public List<MyDto> selectList(){
		Connection con = getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		List<MyDto> list = new ArrayList<>();
		
		String sql = " SELECT MYNO, MYID, MYPW, MYNAME, MYADDR, MYPHONE, MYEMAIL, MYENABLED, MYROLE FROM MYMEMBER ";
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				MyDto dto = new MyDto(
							rs.getInt(1),
							rs.getString(2),
							rs.getString(3),
							rs.getString(4),
							rs.getString(5),
							rs.getString(6),
							rs.getString(7),
							rs.getString(8),
							rs.getString(9)
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
	//enabled 가입여부로 "Y"인 애들만 출력 : Admin(관리자)
	public List<MyDto> selectEnabled() {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<MyDto> list = new ArrayList<MyDto>();
		
		String sql = " SELECT MYNO, MYID, MYPW, MYNAME, MYADDR, MYPHONE, MYEMAIL, MYENABLED, MYROLE FROM MYMEMBER WHERE MYENABLED = 'Y' ";
		
		try {
			pstm = con.prepareStatement(sql);
			rs = pstm.executeQuery();
			while(rs.next()) {
				MyDto dto = new MyDto();
				dto.setMyno(rs.getInt(1));
				dto.setMyid(rs.getString(2));
				dto.setMypw(rs.getString(3));
				dto.setMyname(rs.getString(4));
				dto.setMyaddr(rs.getString(5));
				dto.setMyphone(rs.getString(6));
				dto.setMyemail(rs.getString(7));
				dto.setMyenabled(rs.getString(8));
				dto.setMyrole(rs.getString(9));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
		}
		return list;
	}
	//등급변경 : Admin(관리자)
	public int updateRole(int myno, String myrole) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE MYMEMBER SET MYROLE = ? WHERE MYNO = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, myrole);
			pstm.setInt(2, myno);
			
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
	//회원가입 : user(사용자)
	public int insert(MyDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " INSERT INTO MYMEMBER VALUES ( MYNOSEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, 'Y', 'USER' ) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getMyid());
			pstm.setString(2, dto.getMypw());
			pstm.setString(3, dto.getMyname());
			pstm.setString(4, dto.getMyaddr());
			pstm.setString(5, dto.getMyphone());
			pstm.setString(6, dto.getMyemail());
			
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
	//내 정보조회 : user(사용자)
	public MyDto selectOneUser(int myno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MyDto dto = null;
		
		String sql = " SELECT MYNO, MYID, MYPW, MYNAME, MYADDR, MYPHONE, MYEMAIL, MYENABLED, MYROLE FROM MYMEMBER WHERE MYNO = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, myno);
			
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				dto = new MyDto();
				dto.setMyno(rs.getInt(1));
				dto.setMyid(rs.getString(2));
				dto.setMypw(rs.getString(3));
				dto.setMyname(rs.getString(4));
				dto.setMyaddr(rs.getString(5));
				dto.setMyphone(rs.getString(6));
				dto.setMyemail(rs.getString(7));
				dto.setMyenabled(rs.getString(7));
				dto.setMyrole(rs.getString(9));
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
	//내 정보  수정 : user (사용자) 
	public int updateUser(MyDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE MYMEMBER SET MYPW = ?, MYNAME = ?, MYADDR = ?, MYPHONE = ?, MYEMAIL = ? WHERE MYNO = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getMypw());
			pstm.setString(2, dto.getMyname());
			pstm.setString(3, dto.getMyaddr());
			pstm.setString(4, dto.getMyphone());
			pstm.setString(5, dto.getMyemail());
			pstm.setInt(6, dto.getMyno());
			System.out.println(dto.getMyno() + "여기" + dto.getMypw() + "여기" + dto.getMyname() + "여기" +dto.getMyaddr() + "여기" + dto.getMyphone() + "여기" + dto.getMyemail() + "여기");
			
			
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
	//탈퇴 : user(사용자) / enabled만 Y에서 N으로 변경
	public int deleteUser(int myno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;

		String sql = " UPDATE MYMEMBER SET MYENABLED = 'N' WHERE MYNO = ? ";
		
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
	//중복체크 메서드
	public MyDto idCheck(String myid) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MyDto dto = new MyDto();
		
		//내가 출력하는 아이디가 있는지 없는지 체크해준다.
		String sql = " SELECT MYID FROM MYMEMBER WHERE MYID = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, myid);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				dto.setMyid(rs.getString(1));
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
	//로그인
	//내가 입력한 id와pw를 받아야하기 때문에 파라미터로 myid, mypw를 받아왔다.
	public MyDto login(String myid, String mypw) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		//얘를 리턴할 때에는 안에 있는 값이 없다면 null값을 리턴한다. 그래서 dto != null 을 사용할 수 있다.
		MyDto dto = null;
		
		String sql = " SELECT MYNO, MYID, MYPW, MYNAME, MYADDR, MYPHONE, MYEMAIL, MYENABLED, MYROLE FROM MYMEMBER WHERE MYID = ? AND MYPW = ? AND MYENABLED = ? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, myid);
			pstm.setString(2, mypw);
			pstm.setString(3, "Y");
			
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				//dto의 객체를 생성해줬다.
				dto = new MyDto();
				dto.setMyno(rs.getInt(1));
				dto.setMyid(rs.getString(2));
				dto.setMypw(rs.getString(3));
				dto.setMyname(rs.getString(4));
				dto.setMyaddr(rs.getString(5));
				dto.setMyphone(rs.getString(6));
				dto.setMyemail(rs.getString(7));
				dto.setMyenabled(rs.getString(8));
				dto.setMyrole(rs.getString(9));
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
}
