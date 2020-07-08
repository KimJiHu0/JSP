package com.scroe;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


@WebServlet("/score.do")
public class score extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public score() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//가장 먼저 인코딩을 해줘야한다.
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//ajax로 요청된 값 4개를 받아오기.
		String name = request.getParameter("name");
		int kor = Integer.parseInt(request.getParameter("kor"));
		int eng = Integer.parseInt(request.getParameter("eng"));
		int math = Integer.parseInt(request.getParameter("math"));
		
		//총점을 구하는 sum변수 선언
		int sum = kor + eng + math;
		//평균을 구하는 avg변수 선언
		double avg = sum / 3.0;
		
		//json형태로 바꾸기
		//json객체 생성
		//lib밑에 넣은 jar파일이 import를 도와준다.
		JSONObject obj = new JSONObject();
		obj.put("name", name);
		obj.put("sum", sum);
		obj.put("avg", avg);
		
		//json형태의 문자열로 만들어준다 : toJSONString()
		System.out.println("servlet에서 보내는 msg : " + obj.toJSONString());
		
		//요청했으니까 응답하기.
		PrintWriter out = response.getWriter();
		//obj에 담은 값 name, sum, avg를 json형태의 문자열로 만들어준다.
		out.println(obj.toJSONString());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
