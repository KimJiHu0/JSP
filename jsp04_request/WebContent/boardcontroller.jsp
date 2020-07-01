<%@page import="com.dto.MyDto"%>
<%@page import="java.util.List"%>
<%@page import="com.biz.MyBiz"%>
<%@page import="com.dao.MyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컨트롤러 입니당.</title>
</head>
<body>
<%
	//이 곳의 애들은 전역변수라고 할 수 있다. 어느 jsp에서 command값을 가지고 오면 이 곳에서 가장 먼저 받아주고
	//command를 출력한다.
	String command = request.getParameter("command");
	System.out.println("<" + command + ">");
	//dao와 biz객체를 항상 사용할 수 있게 생성해놨다.
	MyDao dao = new MyDao();
	MyBiz biz = new MyBiz();
	
	
	//글 목록 jsp
	//[ 2. ] index.jsp에서 boardcontroller.jsp로 가면서 command값을 list로 보냈다
	// 위에서 command값을 받아주었기 때문에 현재 command에는 "list"가 들어가 있다.
	//만일 command가 list라면  biz class에서 실행한 selectList의 결과값을 List배열에 담아줬다.
	//그리고 setAttribute해준 것은 "request"객체에 biz.selectList의 결과값을 담은 list를 넣어주고
	//넣어준 객체의 이름을 list라고 지정해주었다.
	//그런 후에 boardmain.jsp로 이동을 해주는데 사실상 이 boardcontroller.jsp에서 boardmain.jsp로
	//바로 넘어가는게 아니라 무조건적으로 Server을 거치게 되어 있다.
	//request객체는 요청한 다음페이지까지만 유지하며 그 후에는 소멸되기 때문에 forward를 사용했다.
	//예를들면  (  a.jsp -> server -> b.jsp  )처럼 요청이 되는데
	//a.jsp에서 server에 도착하면 request가 소멸되지만 forward를 써주면 요청한 페이지 다음페이지까지 유지가 된다.
	//즉 b.jsp까지 객체가 유지된다는 소리이다.
	if(command.equals("list")){
		List<MyDto> list = biz.selectList();
		request.setAttribute("list", list);
		pageContext.forward("boardmain.jsp");
	
	
	//글 작성 jsp
	/*
	[ 6. ] boardmain.jsp에서 글작성 버튼을 눌러서 넘어온 command값 insert를 확인해준다.
	만일 command값이 insert라면 response.sendRedirect해준다.
	일단 글작성 페이지로 가는데 가져갈 데이터가 없기 때문에 바로 boardinsert.jsp로 보내준다.
	response.sendRedirect("요청할페이지");로 작성이 되는데
	boardmain.jsp에서 controller.jspㅔ게 요청했다.
	boardcontroller.jsp가 응답하려다가 sendRedirect를 만나 새롭게 boardinsert.jsp에게 요청을 하고
	그 요청을 받은 jsp가 응답이 된다.
	*/
	} else if(command.equals("insert")){
		response.sendRedirect("boardinsert.jsp");
		
	/*
	[ 8. ]boardinsert에서 text의 값을 다 입력하고 작성완료버튼을 눌렀을때 form태그의 action속성으로 
	controller.jsp로 왔고 command값은 insertRes를 가지고 넘어왔다.
	만일 command값이 insertRes라면. 그곳에서 작성해서 form태그 action속성으로 보낸 값들을 전부 받아준다.
	그리고 insert의 리턴타입은 int이기 떄문에 int형 변수에 biz.insert의 결과값을 넣어준다.
	그리고 res가 1이상이라면 작성에 성공했다는 의미이기 떄문에 
	response.sendRedirect("boardcontroller.jsp?command=list");이 실행된다.
	아까와 똑같다.성공을 했다면 페이지를 이동해야한다. 하지만 controller.jsp를 무조건 거쳐서 가야하기 때문에 거치지만
	대신 command=list를 해줬기 때문에 boardcontroller.jsp에서 command가 list인 if문으로 다시 들어가서
	그곳에 대한 실행을 한다. 결과는 boardmain.jsp의 화면이 나올 것이다.
	*/
	} else if(command.equals("insertRes")){
		String myname = request.getParameter("myname");
		String mytitle = request.getParameter("mytitle");
		String mycontent = request.getParameter("mycontent");
		
		int res = biz.insert(new MyDto(myname, mytitle, mycontent));
		
		if(res > 0){
			/*
			request.setAttribute("list", biz.selectList());
			pageContext.forward("boardcontroller.jsp?command=list");
			*/
			response.sendRedirect("boardcontroller.jsp?command=list");
		}
		
		
		//글 상세보기 jsp
		/*
		[ 10. ]boardmain.jsp에서 제목을 누르면 command값이 selectone이 넘어오고 해당 글에 대한 myno값도 같이 넘어온다.
		만일 command값이 selectone이라면 같이 넘어온 myno값을 받아준다.
		html은 뮨자열로 넘어오기 때문에 정수형으로 형변환을 해준다.
		그리고 dto에 biz.selectOne을 실행한 결과값을 담는다.그리고 그 실행한 결과값을 request객체에 담고
		그 이름을 selectone이라고 지정해줐으며 이것과 함꼐 boardselectone.jsp로 이동하게 된다.
		*/
	}else if(command.equals("selectone")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		MyDto dto = biz.selectOne(myno);
		request.setAttribute("selectone", biz.selectOne(myno));
		pageContext.forward("boardselectone.jsp");
		
		
		//글 수정 jsp
		/*
		[  14. ]boardselectone.jsp에서 form태그와 함께 넘어온 command값과 myno값이 있다.
		상세보기한 해당 페이지의 myno값을 만일 command가 update라면 받아줄 것이다.
		그리고 biz.selectOne()을 실행한 결과값을 dto에 담는다.
		그리고 그 dto를 request객체에 담는데 이 객체의 이름을 updateselect로 지정해주었다.
		그리고 boardupdate.jsp로 함께 넘겨주었다.
		*/
	} else if(command.equals("update")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		
		MyDto dto = biz.selectOne(myno);
		
		request.setAttribute("updateselect",dto);
		pageContext.forward("boardupdate.jsp");
		
		
		/*
		[ 17.]boardupdate.jsp에서 넘겨준 command값 updateRes, 그리고 myno값을 받아온다.
		만일 command가 updateRes라면 !!
		그리고 name이 mytitle, mycontent인 태그 안에 작성한 값을 String에 담아둔다.
		그리고나서 update는 int형 갯수리턴이기 때문에 int형 변수에 biz.update메소드를 실행한 결과값을 넣는다.
		만일 int res가 0보다 크다면 이라는 의미는 수정에 성공했다는 뜻이고, 수정에 성공했다면 command는 list를 가지고
		boardcontroller.jsp로간다. 그럼 if문을 만나면서 boardmain.jsp로 이동하게 될 것이다.
		*/
	} else if(command.equals("updateRes")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		String mytitle = request.getParameter("mytitle");
		String mycontent = request.getParameter("mycontent");
		
		int res = biz.update(new MyDto(myno, mytitle, mycontent));
		
		if(res > 0){
			response.sendRedirect("boardcontroller.jsp?command=list");
		}
		
		
		
		//글 삭제 jsp
		/*
		[ 19. ] boardselectone.jsp에서 삭제버튼을 클릭하여 넘어온 command값 delete라면
		delete와 함께 보내준 클릭한 해당 페이지의 myno값을 그대로 가져왔다.
		그 값을 command가 delete라면 받아주고, int res에 biz.delete를 실행한 결과값을 담아준다.
		res가 0보다 크다면 삭제에 성공했다는 의미이다.
		그럼 바로 boardcontroller.jsp에 command값은 list로 가져가면 controller에서 command가 list인
		if문을 가서 실행되어 boardmain.jsp로 가게 될 것이다..
		*/
		} else if(command.equals("delete")){
		int myno = Integer.parseInt(request.getParameter("myno"));
		
		int res = biz.delete(myno);
		
		if(res > 0){
			response.sendRedirect("boardcontroller.jsp?command=list");
			//request.setAttribute("list", biz.delete(myno));
			//pageContext.forward("boardcontroller.jsp?command=list&myno=" + myno);
		}
	}
	%>
</body>
</html>