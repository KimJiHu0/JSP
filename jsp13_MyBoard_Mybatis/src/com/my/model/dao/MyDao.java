package com.my.model.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.my.model.db.SqlMapConfig;
import com.my.model.dto.MyDto;

public class MyDao extends SqlMapConfig{
	
	private String namespace = "myboard.";
	
	public List<MyDto> selectList(){
		
		//sql문을 직접 실행시킬 수 있는 객체.
		SqlSession session = null;
		List<MyDto> list = null;
		
		//getSqlSessionFactory() : SqlSessionFactory 객체 만들어준거에서 openSession을 통해 session을 만들어줌
		//.openSession(true) : AutoCommit하겠다.
		//SQL을 실행하는 메소드를 제공한다.
		session = getSqlSessionFactory().openSession(true);
		//세션이 열렸고, session.selectList해서 myboard에 selectList찾아서 list에 담는다?
		//mapper.xml(이름을 myboard라고 지정했다.)에서 selectList라는 id를 지정한 애를 실행한 것을
		//selectList에 담아주고 SQL문을 직접 실행시킬 수 있는 session이름의 SqlSession객체에 담아서
		//list에 담아준다.
		list = session.selectList("myboard.selectList");
		//그리고 sql을 직접 실행시킬 수 있는 session 종료.
		session.close();
		
		return list;
	}
	public MyDto selectOne(int myno) {
		//세션객체
		SqlSession session = null;
		//리턴할 값
		MyDto dto = null;
		
		try {
			//전달
			session = getSqlSessionFactory().openSession(true);
			//namescpace : myboard. 까지인 애.
			//myboard.selectOne 을 해주기위해
			//응답
			dto = session.selectOne(namespace+"selectOne", myno);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return dto;
	}
	public int insert(MyDto dto) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.insert(namespace+"insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	public int update(MyDto dto) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(namespace+"update", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	public int delete(int myno) {
		SqlSession session = null;
		int res = 0;
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.delete(namespace+"delete", myno);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
}
