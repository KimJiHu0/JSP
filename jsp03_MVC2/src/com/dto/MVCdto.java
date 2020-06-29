package com.dto;

import java.util.Date;

//dto는 값을 전달해주는 역할을 하는 class이다.
public class MVCdto {
	
	//이 클래스 내에서만 사용할 수 있는 전역변수들을 설정해주었다.
	private int myno;
	private String myname;
	private String mytitle;
	private String mycontent;
	private Date mydate;
	
	
	//객체를 생성할 수 있도록 기본생성자를 만들어준다.
	public MVCdto() {
		
	}
	//파라미터 5개를 받는 생성자를 만들어준다.
	public MVCdto(int myno, String myname, String mytitle, String mycontent, Date mydate) {
		this.myno = myno;
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
		this.mydate = mydate;
	}
	
	//insert할 때 필요한 것들 : myname, mytitle, mycontent
	public MVCdto(String myname, String mytitle, String mycontent) {
		this.myname = myname;
		this.mytitle = mytitle;
		this.mycontent = mycontent;
	}
	//update할 때 필요한 것들 : myno, mytitle, mycontent
	public MVCdto(int myno, String mytitle, String mycontent) {
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
