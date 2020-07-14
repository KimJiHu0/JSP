package com.my.model.dto;

import java.util.Date;

public class MyDto {
	private int myno;
	private String myname;
	private String mytitle;
	private String mycontent;
	private Date mydate;
	
	//생성자 오버로딩 : 같은 이름으로 다른 기능을 하는 것 ( 파라미터 갯수나 타입이 달라야한다 )
	//아래 두개의 생성자가 타입이 아예 같으면 오버로딩이 되지 안됀다.
	public MyDto() {
		
	}
	public MyDto(int myno, String myname, String mytitle, String mycontent, Date mydate) {
		this.myno = myno;
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
		this.mydate = mydate;
	}
	
	//insert할 때 : myname, mytitle, mycontent
	public MyDto(String myname, String mytitle, String mycontent) {
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
	}
	
	//update할 때 : myno, mytitle, mycontent
	public MyDto(int myno, String mytitle, String mycontent) {
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
