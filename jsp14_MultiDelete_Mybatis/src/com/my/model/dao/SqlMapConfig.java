package com.my.model.dao;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapConfig {
	
	//driver, url, user, password를 설정하고, 그것을 config.xml과 연결하고(DB연결)
	//config.xml과 mapper.xml을 mapping해줬기 때문에
	//mybatis를 이용하여 SQL구문만 작성하면 된다.
	//SQL구문을 실행시켜줄 SqlSession을 사용해야하는데
	//SqlSession을 사용하기 위해서는 SqlSessionFactory가 필요하고,
	//이를 만들기 위해서는 SqlSessionFactoryBuilder로 만들어여한다.
	
	private SqlSessionFactory sqlSessionFactory;
	
	public SqlSessionFactory getSqlSessionFactory() {
		
		/*
		 * 경로를 의미 : /
		 * 클래스를 의미 : .
		 * reousrce라는 변수에 config.xml을 담아준다.(db연동 xml)
		 */
		String resource = "com/my/model/db/config.xml";
		//입력받을 Reader 생성!
		Reader reader = null;
		
		try {
			//reader은 io인데 이는 읽어오는 것을 의미한다.
			//Reader이 ()안에 resource를 읽어와서 담는다.
			//.getResourceAsReader(resource); : 내가 입력한 해당 경로를 입력받을 것인데
			//reader가 알아들을 수 있는 타입으로 반환한다..?
			//Resources : 경로가 달라도 자원을 쉽게해주는 유틸성 클래스를 가지고있다
			reader = Resources.getResourceAsReader(resource);
		} catch (IOException e) {
			e.printStackTrace();
		}
		//SqlSessionFactory를 만들기 위해서 Builder를 사용하고 reader를 넣고 그걸 sqlSessionFactory변수에
		//대입하여 입력받은 것을 리턴?
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		
		return sqlSessionFactory;
	}

}
