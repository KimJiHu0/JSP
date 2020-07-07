package com.answer.model.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.answer.model.biz.AnswerBiz;
import com.answer.model.biz.AnswerBizImpl;
import com.answer.model.dto.AnswerDto;


@WebServlet("/controller.do")
public class AnswerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AnswerController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String command = request.getParameter("command");
		System.out.println("<"+command+">");
		
		AnswerBiz biz = new AnswerBizImpl();
		
		//글 목록 전체출력~~~~~~~~~~~~~~~~~~~~~~~~~~~
		if(command.equals("boardlist")) {
			List<AnswerDto> list = biz.selectList();
			request.setAttribute("list", list);
			RequestDispatcher dispatch = request.getRequestDispatcher("boardlist.jsp");
			dispatch.forward(request, response);
		}
		
		//글 작성 창으로 이도옹~~~~~~~~~~~~~~~~!!
		else if(command.equals("insert")) {
			response.sendRedirect("boardinsert.jsp");
		}
		
		//글 작성한거 처리하고 목록페이지로 이도오오오오오옹~~~~~~~~~~~
		else if(command.equals("insertRes")) {
			String writer = request.getParameter("writer");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			//boardno가 시퀀스인 이유 : 글의 번호들을 하나씩 증가시켜주기 위해서.
			//groupno가 시퀀스인 이유 : 내가 새로 작성한 글의 영역이라고 볼 수 있다. 그래서 새로 입력한 글마다 시퀀스가 증가해야한다.
			//groupseq가 시퀀스가 아니고 1인 이유 : 내가 새로 작성한 글이 무조건 1번이어야하기 때문에 내가 속한 영역에서 1번이라는 의미이다.
			//titletab이 시퀀스가 아니고 0인 이유 : 내가 새로 작성한 글은 앞에 공백이 있어선 안되기 때문. 대신 내가 작성한 글 밑으로 댓글을 달 때에는 공백이 있어야한다.
			int res = biz.insert(new AnswerDto(0, 0, 1, 0,"N", title, content, writer, null));
			
			if(res > 0) {
				response.sendRedirect("controller.do?command=boardlist");
			}
		}
		
		//제목을 클릭했을 때 상세보기로 이도오옹~~~~~~~~~~~~~~~~~~~~~~~~
		else if(command.equals("boarddetail")) {
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			AnswerDto dto = biz.selectOne(boardno);
			
			request.setAttribute("dto", dto);
			RequestDispatcher dispatch = request.getRequestDispatcher("boarddetail.jsp");
			dispatch.forward(request, response);
		}
		
		//수정을 눌렀을 때 수정페이지로 이도오오오오옹!!!!!!!!!!!!!!!!!!
		else if(command.equals("boardupdate")) {
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			AnswerDto dto = biz.selectOne(boardno);
			
			request.setAttribute("dto", dto);
			RequestDispatcher dispatch = request.getRequestDispatcher("boardupdate.jsp");
			dispatch.forward(request, response);
		}
		
		//수정을 다 한 후 작업을 수행해주고 원하는 페이지로 이동!!!!!!!!!!!!!!!
		else if(command.equals("boardupdateRes")) {
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			int res = biz.update(new AnswerDto(boardno, 0, 0, 0, "N", title, content, null, null));
			
			if(res > 0) {
				response.sendRedirect("controller.do?command=boarddetail&boardno="+boardno);
			} else {
				response.sendRedirect("failpage.jsp");
			}
		}
		
		//답변 달아보즈아아아아아~~~~~~~~
		else if(command.equals("reply")) {
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			
			AnswerDto dto = biz.selectOne(boardno);
			
			request.setAttribute("dto", dto);
			RequestDispatcher dispatch = request.getRequestDispatcher("boardreply.jsp");
			dispatch.forward(request, response);
		}
		
		//답글다는 명령 수행해주고 넘겨주자아앙~~~~~~~
		else if(command.equals("replyRes")) {
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			String title = request.getParameter("title");
			String writer = request.getParameter("writer");
			String content = request.getParameter("content");
			
			int res = biz.answerProc(new AnswerDto(boardno, 1, 0, 0, null, title, content, writer, null));
			
			if(res > 0) {
				response.sendRedirect("controller.do?command=boardlist");
			} else {
				request.setAttribute("dto", biz.selectOne(boardno));
				RequestDispatcher dispatch = request.getRequestDispatcher("boarddetail.jsp");
				dispatch.forward(request, response);
			}
		}
		
		else if(command.equals("delete")) {
			int boardno = Integer.parseInt(request.getParameter("boardno"));
			
			int res = biz.delete(boardno);
			
			
			if(res > 0) {
				response.sendRedirect("controller.do?command=boardlist");
			} else {
				response.sendRedirect("failpage.jsp");
			}
		}
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
