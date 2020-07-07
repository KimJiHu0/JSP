package com.answer.model.biz;

import java.util.List;

import com.answer.model.dao.AnswerDao;
import com.answer.model.dao.AnswerDaoImpl;
import com.answer.model.dto.AnswerDto;

public class AnswerBizImpl implements AnswerBiz {
	
	AnswerDao dao = new AnswerDaoImpl();

	@Override
	public List<AnswerDto> selectList() {
		return dao.selectList();
	}

	@Override
	public AnswerDto selectOne(int boardno) {
		return dao.selectOne(boardno);
	}

	@Override
	public int insert(AnswerDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int update(AnswerDto dto) {
		return dao.update(dto);
	}

	@Override
	public int delete(int boardno) {
		return dao.delete(boardno);
	}
	
	public int multiDelete(String[] boardno) {
		return dao.multiDelete(boardno);
	}

	@Override
	public int answerProc(AnswerDto dto) {
		
		//부모의 boardno보내줄거다.
		int update = dao.answerUpdate(dto.getBoardno());
		int insert = dao.answerInsert(dto);
		
		System.out.println("u" +update);
		System.out.println("i" +insert);
		
		
		return update + insert;
	}

}
