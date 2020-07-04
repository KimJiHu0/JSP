package com.biz;

import java.util.List;

import com.dto.MyDto;

public interface MyBiz {

	
	//사실상 biz에서는 딱히 계산이라곤 할 게 없지만 나중에 biz를 사용할 있이 있을지도 모르기 때문에 살짝
	//틀만 만들어보고 넘어가도록 하자.
	public List<MyDto> selectList();
	public MyDto selectOne(int seq);
	public int insert(MyDto dto);
	public int update(MyDto dto);
	public int delete(int seq);
	
}
