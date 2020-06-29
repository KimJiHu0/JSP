package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import static com.db.JDBCTemplate.*;

import com.dto.MVCdto;

public class MVCdao {
	
	//전체출력하는 메소드
	public List<MVCdto> selectList(){
		//드라이버연결, 계정연결을 한  메소드를 불러온다.
		Connection con = getConnection();
		//stmt라는 객체 생성.
		//sql문을 실행시키기 위해서 만드는 애다.
		Statement stmt = null;
		//rs라는 객체 생성
		//ResultSet이라는 애는 결과 값을 받는 애다.
		ResultSet rs = null;
		//list 객체 생성
		List<MVCdto> list = new ArrayList<MVCdto>();
		
		//전체출력에 필요한 sql구문을 작성한다.
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT, MYDATE FROM MOKCHA ";
		
		try {
			//sql문장을  쓰기 위해서 자리를 만드는 명령어
			stmt = con.createStatement();
			//sql문을 실행시켜서 나온 결과값을 rs에 담는다는 명령어
			rs = stmt.executeQuery(sql);
			
			//MVCdto dto = new MVCdto();
			//객체생성을 밖에다 해줄 시에 객체가 딱 한번 생성이 된다.
			//값은 여러개인데 똑같은 객체에 담기니까 마지막 값만 출력이 된다.
			
			//rs안에 다음것이 있으면 무한반복해준다.
			while(rs.next()) {
				//dto객체를 생성해주었다.
				//dto객체를 while문 안에다가 작성하면
				//가져온 값들을 담고 또 다른 객체를 생성해서 또 값을 담는다.
				//객체들은 각자 다른 주소값을 가지고 있다.
				MVCdto dto = new MVCdto(
						//rs에 담겨있는 것중에 첫번째 int값을 가져온다는 의미.
						//그리고 그 값을 dto에 넣는다.
						//아래 것들도 마찬각지.
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getDate(5)
						);
				//그리고 값들이 담긴 dto를 list에 추가한다.
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//마지막으로 가장 나중에 생성한 객체부터 close를 해준다.
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	//하나만 골라서 선택출력하는 메소드
	public MVCdto selectOne(int myno) {
		//드라이버 연결과 계정연결을 실행
		Connection con = getConnection();
		//sql문에 값을 넣어줘야할 때 만들어주는 애.
		//pstm 객체생성
		PreparedStatement pstm = null;
		//결과값을 담아줄 rs 객체 생성
		ResultSet rs = null;
		//dto객체 생성 값을 한 줄의 row만 받으면 되기 때문에 한번만 생성해주어도 된다.
		MVCdto dto = new MVCdto();
		
		//쿼리문 준비
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT FROM MOKCHA WHERE MYNO = ? ";
		
		try {
			//con : 자바랑 데이터베이스랑 연결해줄 것.
			//sql구문을 준비시켜준다.
			pstm = con.prepareStatement(sql);
			//pstm에 담긴 sql 구문에 첫번째 물음표에다가 값을 넣어주는데 myno를 넣어준 이유는 내가 선택한 글에 대한 번호를 넣어주기 위해서다.
			//만일 dto.getMyno()를 하게 되면 안에 담긴 값이 아무것도 없기 때문에 0값이 들어간다.
			pstm.setInt(1, myno);
			
			//sql구문이 완벽하게 만들어진 pstm을 실행시켜서 그 결과값을 rs에 담는다.
			rs = pstm.executeQuery();
			
			while(rs.next()) {
				//dto에 myname이라는 컬럼에 값을 넣어줄건데 그 값은 rs에서 나온 첫번째 String 결과값
				//pstm에 담긴 완성된 sql구문을 실행시켜서 rs에 그 결과값을 담고 거기서
				//도출된 row들 중 첫번째 컬럼의 값을 dto에 담아준다.
				dto.setMyno(rs.getInt(1));
				dto.setMyname(rs.getString(2));
				dto.setMytitle(rs.getString(3));
				dto.setMycontent(rs.getString(4));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
		}
		//위에서 결과값들을 전부 담은 dto를 리턴해준다
		return dto;
	}
	//입력한 값을 넣어주는 메소드
	public int insert(MVCdto dto) {
		//드라이버연결, 계정연결을 실행
		Connection con = getConnection();
		//sql구문을 담을 pstm 객체 생성
		PreparedStatement pstm = null;
		//insert에 성공할 시 나오는 결과는 입력성공한 row의 갯수이다.
		//그래서 int값을 반환한다.
		int res = 0;
		
		String sql = " INSERT INTO MOKCHA VALUES (MOKCHASEQ.NEXTVAL, ?, ?, ?, SYSDATE) ";
		try {
			//sql구문을 준비시킨다.
			pstm = con.prepareStatement(sql);
			//위에 sql구문이 담긴 pstm에서 첫번째 물은표에 jsp에서 받은 dto값을 넣어준다.
			pstm.setString(1, dto.getMyname());
			pstm.setString(2, dto.getMytitle());
			pstm.setString(3, dto.getMycontent());
			
			//insert에 성공 결과값의 갯수를 res에 담는다.
			res = pstm.executeUpdate();
			
			//res에 담긴 성공한 결과값을 갯수가 0보다 크다는건 insert에 성공했을 때를 의미한다.
			if(res > 0) {
				//저장!
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		//성공한 결과값을 반환한다.
		return res;
	}
	//입력한 값으로 수정하는 메소드
	public int update(MVCdto dto) {
		//드라이버 연결, 
		Connection con = getConnection();
		//sql구문을 담을 pstm 객체 생성
		PreparedStatement pstm = null;
		//수정에 성공했을 때에도 결과값은 row의 갯수이기 때문에 int를 사용
		int res = 0;
		
		String sql = " UPDATE MOKCHA SET MYTITLE = ?, MYCONTENT = ? WHERE MYNO = ? ";
		
		try {
			//위에서 작성한 sql구문을 pstm에 담는다.
			pstm = con.prepareStatement(sql);
			//sql구문이 담긴 pstm에 첫번째 물음표에 jsp파일이 수정을하고 넘겨준 값을 담는다.
			pstm.setString(1, dto.getMytitle());
			pstm.setString(2, dto.getMycontent());
			//myno는 수정한 해당 게시글의 번호를 받아왔다.
			pstm.setInt(3, dto.getMyno());
			
			res = pstm.executeUpdate();
			
			if(res  > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
		}
		return res;
	}
	//해당 글을 삭제하는 메소드
	public int delete(int myno) {
		//드라이버 연결, 계정연결을 해준다.
		Connection con = getConnection();
		//sql구문을 담을 pstm 객체생성
		PreparedStatement pstm = null;
		//delete도 삭제한 row의 갯수를 반환하기때문에 int사용
		int res = 0;
		
		String sql = " DELETE FROM MOKCHA WHERE MYNO = ? ";
		
		try {
			//위의 sql문을 pstm에 담아 준비시킨다.
			pstm = con.prepareStatement(sql);
			//sql구문을 담은 pstm에 첫번째 물음표에 jsp에서 해당 게시글의 번호를 파라미터로 받아왔기 때문에 myno를 사용
			pstm.setInt(1, myno);
			//sql구문을 실행한다.그리고 그 결과값을 res에 담는다.
			res = pstm.executeUpdate();
			
			//삭제에 성공했다면.
			if(res > 0) {
				commit(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
		}
		return res;
	}

}
