package com.dao;

//아래와 같이 import해준 이유 : com.db패키지에 있는 JDBCTemplate의 모든걸 사용하기 위해서
import static com.db.JDBCTemplate.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.dto.MyDto;

public class MyDao {

	// 전체 row를 출력하는 메소드
	// 하나의 row를 MyDto dto에 담고,
	// 그 dto들을 list에 담기 때문에 전체 row가 출력된다.
	// 한줄의 row는 MyDto, 그를 담아서 관리해서 타입이 List타입.
	public List<MyDto> selectList() {
		// JDBCTemplate에서 작성한 getConnection사용, 드라이버연결과 계정연결
		Connection con = getConnection();

		// stmt라는 객체 생성, sql문을 실행시키기 위해서 작성
		Statement stmt = null;

		// rs라는 객체 생성, 결과를 받기 위해 작성
		ResultSet rs = null;

		// 값들을 담을 list라는 배열을 사용하기 위해 객체 생성.
		List<MyDto> list = new ArrayList<MyDto>();

		// 전체출력 sql문 작성
		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT, MYDATE FROM COMTEST ORDER BY MYNO DESC ";

		try {
			// sql문을 문장을 쓰기 위해서 자리를 만드는 명령어
			stmt = con.createStatement();

			// sql문을 실행시켜서 나온 결과값을 담는 명령어
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				// 객체 생성을 while문 안에 해준 이유는 생성된 하나의 객체에 모든 dto들을 담아주어야 하기 때문이다.
				// while문 밖에 작성하면 하나의 객체에 dto 값이 들어가고 또 다른 하나의 객체가 생성되고 그 안에 dto들이
				// 들어가게 되면 각기 다른 주소값에 값들이 들어가기 때문에 결국엔 마지막에 들어간 값만 출력이 된다.
				MyDto dto = new MyDto(
						// sql문을 실행시켜서 나온 결과값을 담은 rs에서 첫번째에 해당하는 int값을 가져와서 dto에 담는다.
						rs.getInt(1),
						// sql문을 실행시켜서 나온 결과값을 담은 rs에서 두번째에 해당하는 String값을 가져와서 dto에 담는다.
						rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5));
				// 그렇게 만들어진 dto(하나의 row를 의미)를 list에 담는다.
				list.add(dto);
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}

	// 하나의 row를 출력하는 메소드
	// 컬럼하나하나의 값을 MyDto dto에 담기 때문에
	// 한 줄의 row는 dto이다.그래서 타입은 MyDto 타입.
	// 그리고 한줄의 row를 출력할 것이기 때문에 기본키인 myno를 파라미터로 입력.
	public MyDto selectOne(int myno) {
		// 드라이버, 계정연결
		Connection con = getConnection();

		// sql구문에 값을 넣어주어야할 때 만들어주는 pstm 생성
		PreparedStatement pstm = null;

		// sql구문 실행 결과값을 담아줄 rs생성
		ResultSet rs = null;

		// 한 줄의 row를 담아야하기 때문에 while문 밖에 한번만 객체를 생성해준다.
		MyDto dto = new MyDto();

		String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT FROM COMTEST WHERE MYNO = ? ";

		try {
			// con은 java와 database를 연결해주는..
			// sql구문을 준비시킨다.
			pstm = con.prepareStatement(sql);

			// sql구문이 들어간 pstm에 첫번째 물음표에 myno값을 넣어준다. myno를 넣어준 이유는 내가 클릭했을 때
			// 가져올 그 한 줄의 dto(row)에 해당하는 번호를 받아와야하기 때문.
			pstm.setInt(1, myno);

			// 물음표에도 값이 들어간 완벽하게 만들어진 sql문의 실행 결과값을 rs에 담는다.
			rs = pstm.executeQuery();

			while (rs.next()) {
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

	// insert에 성공한 갯수를 반환하기 때문에 int타입이고
	// 모든 컬럼은 not null이기 때문에 한줄의 row를 받아와서
	// 파라미터로 MyDto dto를 입력.
	public int insert(MyDto dto) {
		// 드라이버연결, 계정연결
		Connection con = getConnection();

		// sql구문에 값을 넣어줄 pstm 생성
		PreparedStatement pstm = null;

		// insert에 성공한 갯수를 리턴하기 위해 int형 res변수 생성
		int res = 0;

		// sql문 작성
		String sql = " INSERT INTO COMTEST VALUES(NUMBERNEXT.NEXTVAL, ?, ?, ?, SYSDATE) ";

		try {
			// sql문을 준비시킨다.
			pstm = con.prepareStatement(sql);

			// sql문을 작성한 pstm에 물음표에 값을 넣어준다..
			pstm.setString(1, dto.getMyname());
			pstm.setString(2, dto.getMytitle());
			pstm.setString(3, dto.getMycontent());

			// 물음표에 값을 넣어 완벽하게 준비된 sql문이 pstm에 담겨있는데 이를 실행하여 나온 결과값을 res에 담는다 int형식으로
			res = pstm.executeUpdate();

			// 위에서 sql문을 담은 pstm이 실행에 성공했다면 res에 1이 담길 것이다.insert는 한번만 해줬기 때문에.
			// 그래서 'res가 0 보다 크다면' 이 말은 insert에 성공했다는 의미이다.
			if (res > 0) {
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

	// 수정 성공한 row의 갯수를 리턴할 것이기 때문에 int타입.
	// 수정한 한줄의 row를 받아올 것이기 때문에 파라미터는 MyDto dto
	public int update(MyDto dto) {
		// 드라이버연결, 계정연결
		Connection con = getConnection();

		// sql문에 값을 넣어줘야할 pstm생성
		PreparedStatement pstm = null;

		// update에 성공한 row의 갯수를 반환하기 위해 int형 res변수 선언
		int res = 0;

		// sql구문 선언
		String sql = " UPDATE COMTEST SET MYTITLE = ?, MYCONTENT = ? WHERE MYNO = ? ";

		try {
			// sql구문을 pstm에 넣어준다.(준비해준다)
			pstm = con.prepareStatement(sql);

			// sql구문이 들어간 pstm에 물음표에 값을 넣어준다.
			pstm.setString(1, dto.getMytitle());
			pstm.setString(2, dto.getMycontent());
			pstm.setInt(3, dto.getMyno());

			// 물음표에 값을 넣어 완벽하게 준비된 sql문을 담은 pstm을 실행시켜 결과값을 res에 넣어준다.
			res = pstm.executeUpdate();

			// res는 int형이기 때문에 pstm이 실행된 결과는 1개이기 때문에 그리고 성공했다면 1이 들어갈 것이다.
			// 만일 수정에 성공했다면
			if (res > 0) {
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

	// 삭제에 성공한 갯수를 리턴할 것이기 때문에 int타입.
	// 기본키인 myno를 받아와서 그에 해당한 한줄을 삭제할 것이기 때문에 파라미터로 myno입력.
	public int delete(int myno) {
		// 드라이버, 계정연결
		Connection con = getConnection();
		// sql구문에 값을 넣어줄 수 있는 pstm생성
		PreparedStatement pstm = null;
		// 갯수를 반환할 res선언
		int res = 0;
		// sql구문 선언
		String sql = " DELETE FROM COMTEST WHERE MYNO = ? ";

		try {
			// sql문을 pstm에 넣어준다.
			pstm = con.prepareStatement(sql);
			// sql문에 첫번째 물음표에 파라미터로 받은 myno를 넣어준다.
			pstm.setInt(1, myno);
			// 이를 실행한 결과값을 res에 넣어준다.
			res = pstm.executeUpdate();

			if (res > 0) {
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
	// 삭제에 성공한 row들의 갯수를 입력할 것이기 때문에 int타입이며
	// 여러개 선택을 받아서 삭제할 것이기 때문에 int타입 myno가 아닌
	// 배열에 담은 myno를 파라미터로 입력.

	// 파라미터를 String으로 받은 이유는 문자열이기 때문에.
	// int[]을 사용해도 되는 jsp단에서 parseInt를 해줘서 넘겨주어야 한다.
	public int multidelete(String[] myno) {
		//드라이거 계정 연결
		Connection con = getConnection();

		//sql구문에 값을 넣어줄 pstm생성
		PreparedStatement pstm = null;
		
		//삭제 완료한 갯수리턴해야해서 int형 res변수 설정
		int res = 0;

		//sql구문 선언
		String sql = " DELETE FROM COMTEST WHERE MYNO = ? ";
		
		//삭제에 성공한 값을 담아줄 배열 변수이다.
		//값을 int형으로 받으면 3개를 삭제해도 1개로 인식해서
		//[1, 1, 1] 삭제성공해서 총 3개의 row를 삭제하기 위헤서 배열로 받아왔다.
		int[] cnt = null;

		try {
			//sql문을 pstm에 넣는다.
			pstm = con.prepareStatement(sql);

			/*
			 * 0부터 checked된 것의 길이만큼 for문을 도는데 myno에 체크된 애들의 번호를
			 * 대입해준다. 1번3번5번 글을 삭제한다고 하면 [1, 3, 5] 형식으로 저장.
			 * i번지가 0번지일 때 첫번째 물음표에 0번지에 있는 1을 대입해서 그 애가 메모리에 담기고 반복 형식.
			 * pstm.addBatch() : 임시적으로 메모리에 적재하고 있다고 볼 수 있다.[휴지통 느낌?]
			 * executeBatch를 호출하면 적재되어있던 모든 것들이 삭제된다.
			 */
			for(int i = 0; i < myno.length; i++) {
				pstm.setString(1, myno[i]);
				
				//pstm을 메모리에 적재한다.
				pstm.addBatch();
			}
			//적재한 애들을 삭제하고 cnt에 담는다.
			//삭제에 성공하면 -2를 리턴하고 실패하면 -3을 리턴한다.
			//1,3,5번을 삭제한다고 하면 삭제 성공을 3번 했을 것이다.
			//이는 그럼 리턴이 -2,-2,-2가 되어야한다.
			//이를 받아주기 위해서 cnt는 배열형식으로 선언을 했다.
			//[-2,-2,-2]형식으로 cnt에 담기게 된다.
			cnt = pstm.executeBatch();
			
			//0부터 cnt가 삭제에 성공한 애들의 길이만큼 도는데 만일 cnt의 i번지에 있는 값이 -2라면
			//이 말은 즉 삭제에 성공했다면! res를 ++해준다.
			for(int i = 0; i < cnt.length; i++) {
				if(cnt[i]==-2) {
					res++;
				}
			}
			//그리고 myno배열의 길이와 res의 길이가 같다면, 이 말은 즉 체크된 애들이 모두 잘 삭제됐다면
			if(myno.length == res) {
				//commit해준다
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
