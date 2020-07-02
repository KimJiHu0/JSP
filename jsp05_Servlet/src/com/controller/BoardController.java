package com.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.dao.MVCBoardDao;
import com.mvc.dto.MVCBoardDto;


@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public BoardController() {

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// encoding
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String command = request.getParameter("command");

		System.out.printf("[%s]\n", command);

		MVCBoardDao dao = new MVCBoardDao();

		if (command.equals("list")) {
			// 1.전달해준 값이 있으면 받아준다.
			// 2.db에서 값 가져온다.db연결
			List<MVCBoardDto> list = dao.selectList();
			// 3.전달할 값 request에 담자
			request.setAttribute("list", list);
			// 4.전달
			RequestDispatcher dispatch = request.getRequestDispatcher("boardlist.jsp");
			dispatch.forward(request, response);

		} else if (command.equals("selectone")) {
			// 전달해준 값 받아.
			int myno = Integer.parseInt(request.getParameter("myno"));
			MVCBoardDto dto = dao.selectOne(myno);

			request.setAttribute("select", dto);
			RequestDispatcher dispatch = request.getRequestDispatcher("boardselectone.jsp");
			dispatch.forward(request, response);

		} else if (command.equals("insert")) {
			response.sendRedirect("boardinsert.jsp");
		} else if (command.equals("insertRes")) {
			String myname = request.getParameter("myname");
			String mytitle = request.getParameter("mytitle");
			String mycontent = request.getParameter("mycontent");

			int res = dao.insert(new MVCBoardDto(myname, mytitle, mycontent));
			
			if (res > 0) {
				/*
				 * 새로고침하면 한번 더 ,,,,,,,,,,,,,, 추가됌 ,,,,,,,,,,
				request.setAttribute("list", dao.selectList());
				RequestDispatcher dispatch = request.getRequestDispatcher("boardlist.jsp");
				dispatch.forward(request, response);
				*/
				response.sendRedirect("controller.do?command=list");
			} else {
				response.sendRedirect("boardinsert.jsp");
			}
		} else if(command.equals("delete")) {
			int myno = Integer.parseInt(request.getParameter("myno"));
			
			int res = dao.delete(myno);
			
			if(res > 0) {
				request.setAttribute("list", dao.selectList());
				RequestDispatcher dispatch = request.getRequestDispatcher("boardlist.jsp");
				dispatch.forward(request, response);
			}
		} else if(command.equals("update")) {
			int myno = Integer.parseInt(request.getParameter("myno"));
			request.setAttribute("update", dao.selectOne(myno));
			RequestDispatcher dispatch = request.getRequestDispatcher("boardupdate.jsp");
			dispatch.forward(request, response);
		} else if(command.equals("updateRes")) {
			MVCBoardDto dto = new MVCBoardDto();
			int myno = Integer.parseInt(request.getParameter("myno"));
			String mytitle = request.getParameter("mytitle");
			String mycontent = request.getParameter("mycontent");
			
			int res = dao.update(new MVCBoardDto(myno, mytitle, mycontent));
			
			if(res > 0) {
				
				//request.setAttribute("selectone", dao.selectOne(dto.getMyno()));
				//RequestDispatcher dispatch =  request.getRequestDispatcher("boardselectone.jsp");
				//dispatch.forward(request, response);
			
				//controller.do를 찾아서 가는데 command는 selectone이고 myno값을 가져가는데
				//jsp에서는 html안에 java를 사용학 때문에 <%%>로 사용할 수 있었지만
				//servlet는 myno=myno로 쓰면 myno가 문자열로 들어가서
				//변수로 설정해주기 위해 따로 빼주어야한다.
				response.sendRedirect("controller.do?command=selectone&myno="+myno);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// post로 요청이들어와도 doGet으로 넘겨서 Get방식으로 처리할거라는 의미.
		doGet(request, response);
	}

}
