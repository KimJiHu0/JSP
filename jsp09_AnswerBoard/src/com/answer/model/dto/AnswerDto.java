package com.answer.model.dto;

import java.util.Date;

public class AnswerDto {
	
	private int boardno;
	private int groupno;
	private int groupseq;
	private int titletab;
	private String delflag;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	
	public AnswerDto() {
		
	}
	
	public AnswerDto(int boardno, int groupno, int groupseq, int titletab, String delflag, String title, String content,
			String writer, Date regdate) {
		super();
		this.boardno = boardno;
		this.groupno = groupno;
		this.groupseq = groupseq;
		this.titletab = titletab;
		this.delflag = delflag;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.regdate = regdate;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public int getGroupno() {
		return groupno;
	}
	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}
	public int getGroupseq() {
		return groupseq;
	}
	public void setGroupseq(int groupseq) {
		this.groupseq = groupseq;
	}
	public int getTitletab() {
		return titletab;
	}
	public void setTitletab(int titletab) {
		this.titletab = titletab;
	}
	public String getDelflag() {
		return delflag;
	}
	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
}
