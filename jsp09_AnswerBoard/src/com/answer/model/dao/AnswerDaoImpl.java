package com.answer.model.dao;

import static com.answer.db.JDBCTemplate.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.answer.model.dto.AnswerDto;

public class AnswerDaoImpl implements AnswerDao {

	@Override
	public List<AnswerDto> selectList() {
		Connection con = getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		List<AnswerDto> list = new ArrayList<>();
		String sql = SELECT_LIST_SQL;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				AnswerDto dto = new AnswerDto(
						rs.getInt(1),
						rs.getInt(2),
						rs.getInt(3),
						rs.getInt(4),
						rs.getString(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getDate(9)
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

	@Override
	public AnswerDto selectOne(int boardno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		AnswerDto dto = new AnswerDto();
		
		String sql = SELECT_ONE_SQL;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, boardno);
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				dto.setBoardno(rs.getInt(1));
				dto.setGroupno(rs.getInt(2));
				dto.setGroupseq(rs.getInt(3));
				dto.setTitletab(rs.getInt(4));
				dto.setDelflag(rs.getString(5));
				dto.setTitle(rs.getString(6));
				dto.setContent(rs.getString(7));
				dto.setWriter(rs.getString(8));
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

	@Override
	public int insert(AnswerDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = INSERT_SQL;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getTitle());
			pstm.setString(2, dto.getContent());
			pstm.setString(3, dto.getWriter());
			
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

	@Override
	public int update(AnswerDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = UPDATE_SQL;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getTitle());
			pstm.setString(2, dto.getContent());
			pstm.setInt(3, dto.getBoardno());
			
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

	@Override
	public int delete(int boardno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = DELETE_SQL;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, boardno);
			
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

	@Override
	public int answerUpdate(int parentboardno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = ANSWER_UPDATE_SQL;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, parentboardno);
			pstm.setInt(2, parentboardno);
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

	@Override
	public int answerInsert(AnswerDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = ANSWER_INSERT_SQL;
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, dto.getBoardno());
			pstm.setInt(2, dto.getBoardno());
			pstm.setInt(3, dto.getBoardno());
			pstm.setString(4, dto.getTitle());
			pstm.setString(5, dto.getContent());
			pstm.setString(6, dto.getWriter());
			
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
	public int multiDelete(String[] boardno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE ANSWERBOARD SET DELFLAG = 'Y' WHERE BOARDNO = ? ";
		//삭제에 성공하면 성공한 값들을 담아줄 배열 변수.
		int[] cnt = null;
		
		try {
			pstm = con.prepareStatement(sql);
			/*
			 * 삭제할 값을 여러개 받기 위해서 반복문을 통해 물음표 값을 넣고
			 * addBatch를 사용하고 있다. 임시적으로 메모리에 넣고 이따가 executeBatch를 호출하면 한번에 삭제.
			 */
			
			/*
			 * checked된 것의 길이만큼 for문을 도는데 sql구문에 checked된 번호를 대입해준다.
			 * 1,3,5번을 삭제한다치면 [1,3,5]로 대입이 된다. 배열이기 때문에.
			 * i번지가 0번지일 때 첫번째 물음표에 0번지에 있는 1을 대입해서 pstm에 담고,
			 * i번지가 1번지일 때 두번째 물음표에 1번지에 있는 3을 대입해서 pstm에 담는걸 반복
			 */
			for(int i = 0; i < boardno.length; i++) {
				pstm.setString(1, boardno[i]);
				
				//pstm에 담긴 값들을 addBatch를 이용해서 메모리에 적재해둔다.
				pstm.addBatch();
				System.out.println("삭제할 번호 : " + boardno[i]);
			}
			//위에서 1,3,5를 삭제한다고 하면 삭제 성공 시 리턴값을 담는 변수이다.
			//배열형식이라 [] 안에 담기는데 삭제에 성공하면 -2를 리턴하고 실패하면 -3을 리턴한다.
			//3개의 row를 삭제해야하니 -2,-2,-2이니 cnt에 값을 담을 땐 [-2, -2, -2]가 리턴된다.
			cnt = pstm.executeBatch();
			
			for(int i = 0; i < cnt.length; i++){
				//만일 삭제에 성공했다면 res를 ++해준다.
				if(cnt[i] == -2) {
					res++;
				}
			}
			
			//내가 삭제하려고 checked한 값과 삭제성공한 갯수와 값이 같다면!(만일 다 성공했다면)
			if(boardno.length == res) {
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
