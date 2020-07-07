package com.answer.model.biz;

import java.util.List;

import com.answer.model.dto.AnswerDto;

public interface AnswerBiz {
	
	
	
	public List<AnswerDto> selectList();
	public AnswerDto selectOne(int boardno);
	public int insert(AnswerDto dto);
	public int update(AnswerDto dto);
	public int delete(int boardno);
	public int multiDelete(String[] boardno);
	
	public int answerProc(AnswerDto dto);

}
