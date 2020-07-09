package com.weather.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/weatherOpen")
public class WeatherOpenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request,response);
	}

	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		//js에서 전달 된 값받고
		String code = request.getParameter("code");
		//값 request객체에 담고 code라는 이름 지정해주고
		request.setAttribute("code",code);
		//아래의 경로로 값과 함께 보내준다.
		RequestDispatcher rd = request.getRequestDispatcher("weatherInfo.jsp");
		rd.forward(request, response);
	}

}
