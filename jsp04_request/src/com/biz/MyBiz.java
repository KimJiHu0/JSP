package com.biz;

import java.util.List;

import com.dao.MyDao;
import com.dto.MyDto;

public class MyBiz {
	
	private MyDao dao = new MyDao();
	
	//Biz는 계산,연산처리를 담당한다.
	//이번 예제에서는 계산연산을 처리할 일이 없어서 작성만하고 넘어간다.
	public List<MyDto> selectList(){
		return dao.selectList();
	}
	public MyDto selectOne(int myno) {
		return dao.selectOne(myno);
	}
	public int insert(MyDto dto) {
		return dao.insert(dto);
	}
	public int update(MyDto dto) {
		return dao.update(dto);
	}
	public int delete(int myno) {
		return dao.delete(myno);
	}

}
