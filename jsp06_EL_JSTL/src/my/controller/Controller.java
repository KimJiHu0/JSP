package my.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import my.score.score;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/controller.do")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Controller() {
    	
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//가장 먼저 해야할 것은 request와 response의 Encoding이다.
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//index.jsp에서 a태그 속성으로 controller.do를 주었다.
		//위에서 @WebServlet라는 어노테이션은 xml처럼 따로 servlet-mapping을 하지 않아도
		//자동으로 되는 기능이다. index.jsp에서 a태그를 클릭했을 때
		//이를 찾아서 Controller servlet에 온다.
		//a태그는 get방식이기 때문에 이곳이 실행되는데 command값을 EL로 주었기 떄문에
		//command를 받아주는 명령어를 전역변수로 작성했다.
		String command = request.getParameter("command");
		System.out.println("<"+command+">");
		
		//index.jsp에서 EL이라는 command값을 주었고 만일 command가 EL이라면 eltest.jsp로 가게 하자
		//그곳에서 EL을 사용해볼 것이다.
		if(command.equals("EL")) {
			//score class에서 작성한 파라미터4개 받는 생성자를 만들고 값을 넣어서 선언해주었다,
			score sc = new score("김지후", 87,97,98);
			//이를 request객체에 담고 이름을 score으로 지정해주었다.
			request.setAttribute("score", sc);
			//아래의 객체를 통해서 요청을 넘길 것을 설정하고 forward메소드를 통해서 변수로 넘긴다. insertel.jsp로.
			RequestDispatcher dispatch = request.getRequestDispatcher("insertel.jsp");
			dispatch.forward(request, response);
		} else if(command.equals("JSTL")) {
			//내가 임의의 값들을 db에서가 아닌 이곳에서 넣어주기 위해서 List배열을 사용했다.
			List<score> list = new ArrayList<>();
			
			//for문을 돌리는데 i가 10부터 50까지 한번 for문을 돌떄마다 10씩 늘어날 것이다.
			for(int i = 10; i < 50; i +=10) {
				//score class에서 만든 score를 사용했다.
				//score객체를 for문이 한번돌떄마다 새로운 객체를 만들어주고 이름과 점수 50,50,50에 i를 뒤에 붙여준다.
				score sc = new score("이름"+i, 50+i, 50+i, 50+i);
				//for문이 끝날때까지 만들어준 객체 sc를 list라는 배열에 넣어주었다.
				list.add(sc);
			}
			//request객체에 sc하나하나를 넣어준 list를 담고 이름을 listscore로 지정해줬다.
			request.setAttribute("listscore", list);
			//RequestDispatcher 객체를 통해서 요청을 넘길것을 설정하고 forward메소드를 통해 변수로 넘겼다.
			RequestDispatcher dispatch = request.getRequestDispatcher("scorelist.jsp");
			dispatch.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
