<%@page import="java.util.List"%>
<%@page import="com.my.dto.MyDto"%>
<%@page import="com.my.dao.MyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		String command = request.getParameter("command");
	System.out.println("<" + command + ">");
	MyDao dao = new MyDao();

	if (command.equals("login")) {
		//loginpage에서 보낸 myid값과 mypw값을 받아준다.
		String myid = request.getParameter("myid");
		String mypw = request.getParameter("mypw");
		System.out.println(myid + "<- 아이디" + mypw + "<- 비번");
		MyDto dto = dao.login(myid, mypw);

		/*
		 * dao에서 만든 login메서드에 new MyDto(); 로 생성자를 만들어주었다면 null을 쓸 수 없다.
		 * 객체가 만들어지면서 주소값이 있고, 아무값도 들어가지 않은 객체가 주소값을 리턴하기 때문에 null을 쓸 수 없다.
		 * 만일 객체 생성하고나서도 null을 쓰고 싶다면
		 * dto.getMyname()를 써야한다. myno는 int값이라서 값이 들어가지않으면 0이 들어가서
		 * String타입으로 되어있는 변수 중 아무거나 선택해서 써야한다.
		 */
		if (dto != null) {
			//해당 id와 pw가 있다면! 즉, 가입이 되어있다면
			//session scope에 담았다.
			session.setAttribute("dto", dto);
			
			//session 유효시간은 10분동안  활동이 없으면 자동 invaildate된다.
			//default : 30분 / 음수일 때 무제한
			session.setMaxInactiveInterval(10 * 60);

			
			//만일 role가 ADMIN이라면 adminmain.jsp로 이동하고
			if (dto.getMyrole().equals("ADMIN")) {
				response.sendRedirect("adminmain.jsp");
			//만일 role 이 USER이라면 usermain.jsp로 이동하자.
			} else if (dto.getMyrole().equals("USER")) {
				response.sendRedirect("usermain.jsp");
			} else{
%>
			<script type="text/javascript">
			alert("login fail");
			location.href="index.jsp";
			</script>
<%
			}
		}
	}
	//command가 userinfo라면 userinfo.jsp로 이동을 시켜준다.
	else if(command.equals("userinfo")){
		//usermain.jsp에서 내정보보기를 클릭했을 때 넘어온 myno를 받아준다.
		int myno = Integer.parseInt(request.getParameter("myno"));
		
		//내가 선택한 , 내가 로그인한 아이디의 정보를 봐야하기 때문에 selectOneUser을 실행해주는데 파라미터로 myno를 넣어준 이유는
		//내가 선택한 아이디이기 떄문이다.
		MyDto dto = dao.selectOneUser(myno);
		
		//request라는 객체에 위에서 실행한 결과값을 담고 그의 이름을 dto라고 칭한다.
		request.setAttribute("dto", dto);
		//그리고 userinfo.jsp로 위의 결과값을 보내면서 페이지 이동을 해준다.
		pageContext.forward("userinfo.jsp");
		
		
		//수정창
	} else if(command.equals("userinfoupdate")){
		//userinfo.jsp에서 보낸 myno값을 받아준다.
		int myno = Integer.parseInt(request.getParameter("myno"));
		//여기서도 수정페이지로 갈때 selectOneUser메소드를 실행해야한다.
		MyDto dto = dao.selectOneUser(myno);
		//그 결과값을 request객체에 담고 dto라는 이름을 붙인다.
		request.setAttribute("dto", dto);
		//그리고 userinfoupdate.jsp로 이동한다.
		pageContext.forward("userinfoupdate.jsp");
		
		
		//수정
	} else if(command.equals("userinfoupdateRes")){
		//userinfoupdate.jsp에서 보낸 myno값과 mypw, myname, myaddr, myphone, myemail을 받아준다.
		int myno = Integer.parseInt(request.getParameter("myno"));
		String mypw = request.getParameter("mypw");
		String myname = request.getParameter("myname");
		String myaddr = request.getParameter("myaddr");
		String myphone = request.getParameter("myphone");
		String myemail = request.getParameter("myemail");
		
		//System.out.println(myno + "여기" + mypw + "여기" + myname + "여기" +myaddr + "여기" + myphone + "여기" + myemail + "여기");
		//update는 수정완료된 갯수를 리턴한다. dao에서 updateUser메소드를 실행한다.
		int res = dao.updateUser(new MyDto(myno, null, mypw, myname, myaddr, myphone, myemail, null, null));
		
		//그 결과값이 0보다 크다면 수정에 성공했다는 뜻이다.
		if(res > 0){
			//request.setAttribute("dto", dao.selectOneUser(myno));
			//pageContext.forward("controller.jsp?command=userinfo");
			response.sendRedirect("controller.jsp?command=userinfo&myno="+myno);
		}
		
		
		//로그아웃
	} else if(command.equals("logout")){
		//session에 남아있는 정보를 지운다? 만료시킨다? 라고 볼 수 있다.
		session.invalidate();
		//그리고 바로 index.jsp로 보내준다.
		response.sendRedirect("index.jsp");
	}
	
	//회원가입을 클릭하면 userregist.jsp로 간다.
	else if(command.equals("regist")){
		response.sendRedirect("userregist.jsp");
	}
	
	else if(command.equals("registRes")){
		//회원가입할 시에 입력하는 모든 값들을 받아준다.
		String myid = request.getParameter("myid");
		String mypw = request.getParameter("mypw");
		String myname = request.getParameter("myname");
		String myaddr = request.getParameter("myaddr");
		String myphone = request.getParameter("myphone");
		String myemail = request.getParameter("myemail");
		
		//회원가입에 성공한 갯수를 리턴해주기 떄문에 int값에 넣어주는데 Dto에서 회원가입을 해줄 수 있는 생성자를 따로 만들어서
		//실행시킨 다음에 res에 담는다.
		int res = dao.insert(new MyDto(myid, mypw, myname, myaddr, myphone, myemail));
		
		if(res > 0){
			//만일 회원가입에 성공했다면 index.jsp로 보내준다.
			response.sendRedirect("index.jsp");
		}
	}
	
	//탈퇴
	else if(command.equals("Leave")){
		//내가 로그인한 user의 정보를 가져오고 그에 대한 해당 번호를 받아온다.
		int myno = Integer.parseInt(request.getParameter("myno"));
		
		//delete해주는 메소드를 실행해준 다음에 res에 결과값을 담는다.
		int res = dao.deleteUser(myno);
		
		if(res > 0){
			//만일 성공했다면 주저없이 index.jsp로 보내주자.
			response.sendRedirect("index.jsp");
		}
	}
	
	//관리자페이지에서 유저 전체출력
	else if(command.equals("selectuserall")){
		//관리자 로그인을 한 후에 회원들의 전체출력을 위해서  모든 값들을 출력해준 다음에 request에 담은 후에
		//내가 보내줄 페이지로 값과 홤께 보내준다.
		List<MyDto> list = dao.selectList();
		request.setAttribute("list", list);
		pageContext.forward("adminlist.jsp");
	}
	
	//관리자페이지에서 enabled가 Y인애들만출력
	else if(command.equals("selectenabled")){
		//enabled가 Y인 애들만 출력하기 위해서 Dao에 sql구문 where절에 myenabled='Y'로 지정을 해줬다.
		//그렇기 떄문에 selectEnabled메소드를 실행해준 다음에 request에 담고 그 값과 원하는 페이지로 보내준다.
		List<MyDto> list = dao.selectEnabled();
		request.setAttribute("list", list);
		pageContext.forward("adminenabledlist.jsp");
	}
	
	//등급변경
	else if(command.equals("updaterole")){
		//등급변경을 눌렀을 때 해당 회원의 정보를 출력하기 위해서 번호를 받아온 후
		int myno = Integer.parseInt(request.getParameter("myno"));
		//그 유저 한 명의 정보를 출력해주기 위한 메소드를 실행해서 그 값을 담고 adminupdaterole.jsp로 뿌려준다.
		MyDto dto = dao.selectOneUser(myno);
		request.setAttribute("dto", dto);
		pageContext.forward("adminupdaterole.jsp");
	}
	
	else if(command.equals("updateroleRes")){
		//adminupdaterole.jsp에서 해당 회원의 번호를 받아 왔다,
			int myno = Integer.parseInt(request.getParameter("myno"));
			//그리고 role을 바꿨기 때문에 바꾼 값을 받아주고
			String myrole = request.getParameter("myrole");
			//updaterole메소드를 실행해서 결과값을 담아준다.
			int res = dao.updateRole(myno, myrole);
			
			if(res > 0){
				/* List<MyDto> list = dao.selectEnabled();
				request.setAttribute("list", list);
				pageContext.forward("adminupdaterole.jsp"); */
				response.sendRedirect("controller.jsp?command=selectenabled");
			}
	}
	
	else if(command.equals("idcheck")){
		//userregist에서 중복체크시 넘겨준 값인 id를 받아준다.
		String id = request.getParameter("id");
		
		//아이디 중복체크를 위해서 dao만든 중복체크 메서드 실행.
		MyDto dto = dao.idCheck(id);
		
		boolean idnotused = true;
		if(dto.getMyid() != null){
			idnotused = false;
		}
		response.sendRedirect("idcheck.jsp?idnotused="+idnotused);
		
		
	}
	%>

</body>
</html>