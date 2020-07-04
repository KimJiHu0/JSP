package com.dao;

import java.util.List;

import com.dto.MyDto;

public interface MyDao {
	
	String SELECTLIST_SQL = " SELECT SEQ, WRITER, TITLE, CONTENT, REGDATE FROM MVCBOARD ORDER BY SEQ DESC ";
	String SELECTONE_SQL = " SELECT SEQ, WRITER, TITLE, CONTENT FROM MVCBOARD WHERE SEQ = ? ";
	String INSERT_SQL = " INSERT INTO MVCBOARD VALUES(MVCBOARDSEQ.NEXTVAL, ?, ?, ?, SYSDATE) ";
	String UPDATE_SQL = " UPDATE MVCBOARD SET TITLE = ?, CONTENT = ? WHERE SEQ = ? ";
	String DELETE_SQL = " DELETE FROM MVCBOARD WHERE SEQ = ? ";

	
	//interface이기 때문에 현재 class를 상속받는 자식 class는 무조건 아래의 메소드를 구현해야한다.
	public List<MyDto> selectList();
	public MyDto selectOne(int seq);
	public int insert(MyDto dto);
	public int update(MyDto dto);
	public int delete(int seq);
}
