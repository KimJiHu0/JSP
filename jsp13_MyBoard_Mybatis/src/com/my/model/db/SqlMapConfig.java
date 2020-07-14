package com.my.model.db;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapConfig {
	
	//내부적으로 SqlSessionFactory를 가지고 있다.
	private SqlSessionFactory sqlSessionFactory;
	
	//Mybatis를 사용하기 위헤서는 SqlSession을 사용해야한다.
	//SqlSession은 SQL실행 및 트랜잭션 제어를 위한 API를 제공하는 구성요소
	//데이터베이스에서 엑세스 할 때 가장 중요한 역할을 하는 구성 요소
	public SqlSessionFactory getSqlSessionFactory() {
		
		//경로라서 .대신에 /로
		//class를 의미할땐 .
		//경로를 의미할땐 /
		//resource라는 변수에 아래의 경로를 넣어준다.
		//경로는 DB와 연동해주는 XML이다.
		String resource = "com/my/model/db/mybatis-config.xml";
		//입력받을 inputStream변수 생성(InputStream객체 생성)
		InputStream inputStream = null;
		try {
			//io : 읽어오는 것 inputStream
			//resources를 읽어와서
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			e.printStackTrace();
		}
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		
		return sqlSessionFactory;
	}

}
