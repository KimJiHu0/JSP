<%@page import="com.my.dto.MyBoardDto"%>
<%@page import="com.my.dao.MyBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- myinsert.jsp에서 가져온 name,title,content를 DB에 넣어주기 위한 jsp -->
	<!-- 서버 : java client : html. 실행은 서버를 먼저 실행하기 때문에  -->
	<!-- 
	doc을 만드는데 jsp로 만들었다. html안에 java가 들어간다.
	클라이언트가 서버에 요청했다. 서버는 해당 요청에 맞는 doc을 혹은 data를 응답.
	클라이언트가 myselect.jsp를 요청했을 때 서버에서는 jsp파일의 경로를 먼저 찾는다.
	서버 내부에서는 java가 들어간 jsp를 컴파일해서 html로 만들어서 응답.
	Dao클래스를 통해서..DB에 있는 데이터를 가져와주는 역할.
	java영역이 먼저 실행되고 실행된 결과를 응답하기 때문에 html은 클라이언트에서 사용이 될 것.
	java -> html 이 방향으로 늘 흘러간다.
	html - > java가 되지 않기 때문에 res를 만들어준다.
	클라이언트가 서버한테 페이지(jsp)를 요청하면 서버에서는 컴파일을 하는데
	DB에서 데이터를 가져와달고해서  이는 JAVA형식이기 때문에 JAVA먼저 실행을 해주고
	html로 바꿔서 클라이언트에 응답한다.
	컴파일 : 컴터로 알아들을 수 있는 언어로 번역.
	
	여기선 myinsert.jsp에서 가져온 값을 db에 전달해서 return된 값을 가지고 응답 성공인지 실패인지.
	 -->
	<!-- 총정리 클라이언트가 서버에게 jsp파일을 요청하면 java 부분을 컴파일하다가 -->
	<!-- 거기 컴파일 부분에 데이터베이스에서 무언가를 가져와라 하고 있는 코드가 있으면 -->
	<!-- 또 그걸 데이터베이스에 들려서 원하는 값을 가져오고 그걸 html파일로 바꿔서 클라이언트에 내보내줌 -->
	 <%
	 	String myname = request.getParameter("myname");
	 	String mytitle = request.getParameter("mytitle");
	 	String mycontent = request.getParameter("mycontent");
	 	//이것들을 db에 전달
	 	
	 	MyBoardDao dao = new MyBoardDao();
	 	//myno는 시퀀스로 알아서 증가할거고 date는 sysdate를 넣어줄거라서 입력x
	 	int res = dao.insert(new MyBoardDto(0, myname, mytitle, mycontent, null));
	 	
	 	//insert 성공했다면
	 	if(res > 0){
	 %>
	 <script type="text/javascript">
	 	alert("글 작성 성공!");
	 	location.href='mylist.jsp';
	 </script>
	 <%
	 	} else {
	 %>
	 	<script type="text/javascript">
	 		alert("글 작성 실패!");
	 		location.href='myinsert.jsp';
	 	</script> 
	 <%		
	 	}
	 %>
</body>
</html>