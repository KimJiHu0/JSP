package com.dto;

import java.util.Date;


//값을 보내고 가져오는 역할을 하는 class
public class MyDto {

	private int myno;
	private String myname;
	private String mytitle;
	private String mycontent;
	private Date mydate;
	
	public MyDto() {
		
	}
	
	//전체를 사용하는 생성자 (select)
	public MyDto(int myno, String myname, String mytitle, String mycontent, Date mydate) {
		super();
		this.myno = myno;
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
		this.mydate = mydate;
	}
	
	//insert할 때 필요한 생성자
	public MyDto(String myname, String mytitle, String mycontent) {
		super();
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
	}
	
	//update할 때 필요한 생성자
	public MyDto(int myno, String mytitle, String mycontent) {
		super();
		this.myno = myno;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
	}
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
