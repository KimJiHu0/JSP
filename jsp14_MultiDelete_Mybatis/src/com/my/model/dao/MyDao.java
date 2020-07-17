package com.my.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.my.model.dto.MyDto;

public class MyDao extends SqlMapConfig {
	
	//마지막에 .을 붙여준 이유는 namespace를 이용하여 어느 mapper의 메소드인지 찾기 위해.
	private String namespace = "mytest.";
	
	public List<MyDto> selectList(){
		//SQL구문을 실행하기 위한 SqlSession객체, 변수명 session 선언
		SqlSession session = null;
		//전제출력이기 때문에 list를 선언
		List<MyDto> list = null;
		
		try {
			//getSqlSessionFactory() : SQL구문을 사용하기 위해 SqlSession을 만들어줄 메소드 출력
			//.openSession(false); : autocommit을 false해준다.(해주지 않는다.)
			session = getSqlSessionFactory().openSession(false);
			
			//mapper.selectList를 하면 어떤 mapper에 있는 selectList인지 모른다.
			//그래서 전역변수로 mapper의 이름?을 지정해준 것을 가져와서 사용하는데 풀어쓰자면
			//mytest.selectList가 될 것이다. 그럼 mytest에 있는 selectList를 실행시킨다.
			list = session.selectList(namespace+"selectList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
	public MyDto selectOne(int myno) {
		//Sql문을 실행시킨 객체 생성
		SqlSession session = null;
		//값들을 담을 dto생성
		MyDto dto = null;
		
		try {
			//getSqlSessionFactory() : Sql문을 사용하기 위해선 SqlSession이 필요
			//SqlSession을 사용하려면 Factory를 만들어야해서 메소드 호출
			//openSession(false) : AutoCommit false
			session = getSqlSessionFactory().openSession(false);
			//dto에 mytest(namespace).selectOne실행 후 담기. 넘길 값은 int myno
			dto = session.selectOne(namespace+"selectOne", myno);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return dto;
	}
	public int insert(MyDto dto) {
		//SQL문을 실행시킬 SqlSession 객체 선언!
		SqlSession session = null;
		//결과값을 담아줄 res 선언!
		int res = 0;
		
		try {
			//선언한 session에 SqlSession을 만들어줄 Factory메소드 호출 후
			//AutoCommit은 false로 설정
			session = getSqlSessionFactory().openSession(false);
			//결과에 SQL을 실행시킬 변수 session에 insert문을 실행시키는데
			//namespace(mapper.xml에 mytest.)insert를 찾아가고 파라미터 dto
			res = session.insert(namespace+"insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	public int update(MyDto dto) {
		//Sql문을 실행시켜줄 session변수 선언
		SqlSession session = null;
		//결과값을 담아줄 res변수 선언
		int res = 0;
		
		try {
			//Sql을 실행시켜줄 session을 선언한 것에 담을것이다.
			//getSqlSessionFactory() : SqlSession을 생성하는 메소드 호출
			//openSession(false) : AutoCommit false
			session = getSqlSessionFactory().openSession(false);
			//결과값을 담을 res에 session을 실행시킬건데
			//session은 Mybatis이기 때문에 내장적으로
			//update, selectOne, selectList .. 등등 있다.
			//괄호 안에있는 (mapper.xml의 이름을 설정해준것 + update)에 보내줄건데
			//dto를 파라미터로 보내준다.
			//session에 내장되어있는 update를 실행시켜서 res에 담는다.
			res = session.update(namespace+"update", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	public int delete(int myno) {
		//Sql을 타입의 session을 생성
		SqlSession session = null;
		//결과겂을 담아줄 res선언
		int res = 0;
		
		try {
			//SqlSession타입의 session에다가 SqlSession을 만들어줄 Factory메소드 호출
			//AutoCommit 은 false
			session = getSqlSessionFactory().openSession(false);
			//결과겂을 담아줄 res에
			//session객체에 delete메소드를 실행하는데
			//()안에 값을 담아서 보내줌.
			//mytest.delete에 myno를 파라미터로 보냄.
			res = session.delete(namespace+"delete", myno);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	public int multiDelete(String[] myno) {
		//SqlSession타입의 session 변수 생성
		SqlSession session = null;
		//결과값을 담아줄 count생성
		int count = 0;
		//Map에는 String과 String배열이 들어올 수 있고 이름은 map이다.
		Map<String, String[]>map = new HashMap<>();
		//map에 담을거다."mynos"라는 이름으로 myno를!
		map.put("mynos", myno);
		
		try {
			//session이라는 변수에 SQL문을 실행시켜줄 SqlSession생성하는 Factory 메서드 호출
			//AutoCommit은 false
			session = getSqlSessionFactory().openSession(false);
			//count에 delete를 담을건데 mapper.xml에 muldel이라는 id를 가진 태그를 실행시키고
			//map이라는 파라미터를 보낸다,
			count = session.delete(namespace+"muldel", map);
			
			//결과값을 갯수와 myno배열의 길이와 같다면
			//멀티삭제에 성공한 count의 갯수와 선택한 배열한 length이 같다면!
			if(count == myno.length) {
				session.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return count;
	}
}
