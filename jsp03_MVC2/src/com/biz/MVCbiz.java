package com.biz;

import java.util.List;

import com.dao.MVCdao;
import com.dto.MVCdto;

//계산,연산,처리를 도와주는 역할이다.
//mvc 중에서 m에 해당하는 class
public class MVCbiz {
	
	//처리할 계산이 없어서 이렇게 마무리 지었다.
	private MVCdao dao = new MVCdao();
	
	public List<MVCdto> selectList(){
		return dao.selectList();
	}
	public MVCdto selectOne(int myno) {
		return dao.selectOne(myno);
	}
	public int insert(MVCdto dto) {
		return dao.insert(dto);
	}
	public int update(MVCdto dto) {
		return dao.update(dto);
	}
	public int delete(int myno) {
		return dao.delete(myno);
	}
	
}
