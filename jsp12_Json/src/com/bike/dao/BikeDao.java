package com.bike.dao;

import static com.bike.db.JDBCTemplate.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.bike.dto.BikeDto;


public class BikeDao {
	public List<BikeDto> selectList(){
		return null;
	}
	
	//insert를 실행시 컨트롤러에서 bikes에 넘겨준 값을 파라미터로 받는다.
	//DB저장 버튼을 누르게 될 시에 그 JSP에 있던 모든 list들이 저장되게 해야한다.
	//그럼 그 모든 list값을 파라미터로 받아서 만들어야한다.
	public int insert(List<BikeDto> bikes) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		//성공한 값을 배열로 받을 cnt를 선언	
		int[] cnt = null;
		
		String sql = " INSERT INTO BIKE_TB " +
					 " VALUES(?, ?, ?, ?, ?, ?, ?) ";
		
		try {
			pstm = con.prepareStatement(sql);
			//가져온 list의 사이즈만큼 for문을 돌아주면서 pstm에 값들을 담아준다.
			//0부터 파라미터로 받은 BIKES의 크기만큼 for문을 돌 것이다.
			for(int i = 0; i < bikes.size(); i++) {
				//각각의 물음표의 번지수에 bikes의 i번지에 있는 addr_gu의 값을 담고.. 반복
				pstm.setString(1, bikes.get(i).getAddr_gu());
				pstm.setInt(2, bikes.get(i).getContent_id());
				pstm.setString(3, bikes.get(i).getContent_nm());
				pstm.setString(4, bikes.get(i).getNew_addr());
				pstm.setInt(5, bikes.get(i).getCradle_count());
				pstm.setDouble(6, bikes.get(i).getLongitude());
				pstm.setDouble(7, bikes.get(i).getLatitude());
				
				//그 값들을 모두 메모리에 적재해준다.
				pstm.addBatch();
			}
			//cnt배열에 pstm에 적재시킨 값들을 모두 실행시킨다.(1163개의 값을.) insert에 성공한다면 -2리턴
			cnt = pstm.executeBatch();
			//for문을 cnt의 길이만큼 돌아주는데
			for(int i = 0; i < cnt.length; i++) {
				//만일 cnt의 0번지부터 마지막번지까지 -2라면 (성공했다면)
				if(cnt[i] == -2) {
					//성공할때마다 res를 ++해준다.
					res++;
				}
			}
			//만약에 bikes의 size와 res(성공할때마다 늘어난 수)가 같다면 = 모두 성공했다면
			if(bikes.size() == res) {
				//커밋
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
	
	public boolean delete() {
		Connection con = getConnection();
		Statement stmt = null;
		int res = 0;
		String sql = " DELETE FROM BIKE_TB ";
		
		try {
			stmt = con.createStatement();
			res = stmt.executeUpdate(sql);
			
			if(res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(stmt);
			close(con);
		}
		
		return (res > 0)? true : false;
	}
}
