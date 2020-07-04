package com.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.biz.MyBiz;
import com.biz.MyBizImpl;
import com.dto.MyDto;

/**
 * Servlet implementation class controller
 */
@WebServlet("/controller")
public class controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public controller() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		System.out.println("<"+command+">");
		
		MyBiz biz = new MyBizImpl();
		
		if(command.equals("list")) {
			request.setAttribute("list", biz.selectList());
			RequestDispatcher dispatch = request.getRequestDispatcher("boardmain.jsp");
			dispatch.forward(request, response);
		} else if(command.equals("insert")) {
			//boardmain.jsp에서 글작성을 누르면 insert를 command값을 보냈는데
			//글작성 jsp로 가기 위해서는 아무런 값을 들고가지 않아도 된다.
			//굳이 set하고 get할 필요가 없다는 뜻이다.
			response.sendRedirect("boardinsert.jsp");
			
		} else if(command.equals("insertRes")) {
			//boardinsert.jsp에서 넘겨준 name들의 값들을 받아와야한다.
			String writer = request.getParameter("writer");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			//받아온 값들을 insert메소드에 담아 실행시켜주어야한다.
			int res = biz.insert(new MyDto(writer, title, content));
			
			if(res > 0) {
				
				/*
				 * 이처럼 작성하게되면 작성성공하고 list로 가지만 새로고침을 누를때마다 새로운 글이 올라간다.
				 * 객체가 소멸되지 않아서인듯 싶다.
				 * request.setAttribute("list", biz.selectList()); RequestDispatcher dispatch =
				 * request.getRequestDispatcher("boardmain.jsp"); dispatch.forward(request,
				 * response);
				 */
				//어차피 boardmain.jsp로 가게 되면 그 jsp안에서 추가된 것들까지 for문을 돌려서 화면에 출력하게 되어있다.
				//그래서 굳이 값을 가지고 갈 필요가 없다. 아래처럼 바로 보내주는데 controller.do를 통해 command는 list를 가져가면
				//boardmain.jsp에 갈 수 있고 위와 같은 현상은 나타나지 않는다.
				response.sendRedirect("controller.do?command=list");
			}
		} else if (command.equals("detail")) {
			//command가 detail이라면 우리는 일단 상세보기창으로 보내주어야한다.
			//이때 제목을 클릭했을 때 command값과 같이 넘어온 seq값을 받아주고 selectOne메소드를 실행시켜서
			//값을 보내주어야한다.
			int seq = Integer.parseInt(request.getParameter("seq"));
			System.out.println(seq + "여기입니다.");
			//return type이 MyDto인 selectOne 메소드를 dto에 담고 보내주어야한다.
			MyDto dto = biz.selectOne(seq);
			//selectOne실행결과값을 request객체에 담고 이름을 dto라고 해주었다.
			//이제 boarddetail.jsp에서 dto라는 이름의 request객체를 받아주어야한다.
			request.setAttribute("dto", dto);
			RequestDispatcher dispatch = request.getRequestDispatcher("boarddetail.jsp");
			dispatch.forward(request, response);
		}else if(command.equals("update")) {
			//boarddetail.jsp에서 보낸 seq값을 받아왔다.
			int seq = Integer.parseInt(request.getParameter("seq"));
			//그리고 우리는 수정이라는 버튼을 클릭했을 때 해당 페이지의 모든 값들을 가지고 가야한다.
			//그러려면 selectOne을 한번 더 써서 가져간 후에 그 안에서 수정을 할 수 있게 해야한다.
			MyDto dto = biz.selectOne(seq);
			
			request.setAttribute("dto", dto);
			RequestDispatcher dispatch = request.getRequestDispatcher("boardupdate.jsp");
			dispatch.forward(request, response);
		}else if(command.equals("updateRes")) {
			//boardupdate에서 수정해서 보낸 값들을 받아야한다.
			int seq = Integer.parseInt(request.getParameter("seq"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			int res = biz.update(new MyDto(seq, title, content));
			
			if(res > 0) {
				//만일 성공했다면 우리는 boarddetail.jsp로 보내야한다.
				//보내기 위해서는 controller을 들러서 가는데 command를 detail로 해놓으면 selectOne페이지로
				//가게 될 것인데 이때 seq값을 가지고 가야한다. 하지만 seq를 "" 안에 넣으면
				//문자열 그대로 인식하기 때문에
				//java에서는 ""안에서 뺴와서 변수로 사용하여야 값이 나온다.
				response.sendRedirect("controller.do?command=detail&seq="+seq);
			}
		} else if(command.equals("detele")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			//삭제할 해당 페이지의 값을 받아온 후에.
			//삭제 메소드를 실행
			int res = biz.delete(seq);
			
			//만약 삭제에 성공했다면 가져갈 값은 없고 바로 보내주면 되기 때문에 controller.do를 찾아
			//controller로 다시 와서 command가 list인 if문으로 들어가서 안의 명령문에 따라 실행될 것이다.
			if(res > 0) {
				response.sendRedirect("controller.do?command=list");
			}
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
