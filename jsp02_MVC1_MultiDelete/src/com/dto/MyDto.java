package com.dto;

import java.util.Date;

public class MyDto {
	//전역변수를 설정한다.
	private int myno;
	private String myname;
	private String mytitle;
	private String mycontent;
	private Date mydate;
	
	public MyDto() {
		
	}
	//insert할 때 : 이름, 제목, 내용을 입력할 것이기 때문에 아래와 같이 3개를 입력받는 생성자 만들기
	public MyDto(String myname, String mytitle, String mycontent) {
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
	}
	//update할 때 : 그 글에 해당하는 번호, 제목, 내용을 수정할 것이기 때문에 아래와 같이 3개를 입력받는 생성자 만들기
	public MyDto(int myno, String mytitle, String mycontent) {
		this.myno = myno;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
	}
	//전부 다 입력받는 파라미터5개짜리 생성자 만들기
	public MyDto(int myno, String myname, String mytitle, String mycontent, Date mydate) {
		super();
		this.myno = myno;
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
		this.mydate = mydate;
	}
	
	//값을 받아주고 전달해줄 getter, setter을 만든다.
	public int getMyno() {
		return myno;
	}
	public void setMyno(int myno) {
		this.myno = myno;
	}
	public String getMyname() {
		return myname;
	}
	public void setMyname(String myname) {
		this.myname = myname;
	}
	public String getMytitle() {
		return mytitle;
	}
	public void setMytitle(String mytitle) {
		this.mytitle = mytitle;
	}
	public String getMycontent() {
		return mycontent;
	}
	public void setMycontent(String mycontent) {
		this.mycontent = mycontent;
	}
	public Date getMydate() {
		return mydate;
	}
	public void setMydate(Date mydate) {
		this.mydate = mydate;
	}
}
