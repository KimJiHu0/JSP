<%@page import="com.dto.MyDto"%>
<%@page import="com.dao.MyDao"%>
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
	<%
		//boardinsert.jsp에서 입력하고 submit이벤트가 발생하면서 이 jsp페이지로
		//값들이 전부 넘어온다.이들을 전부 받아준다.
		String myname = request.getParameter("myname");
		String mytitle = request.getParameter("mytitle");
		String mycontent = request.getParameter("mycontent");
		
		//dao를 사용하기 위한 객체생성
		MyDao dao = new MyDao();
		//insert는 입력 성공한 갯수를 리턴할 것이기 때문에 int res에 dao를 실행한 결과값을 담아준다.
		int res = dao.insert(new MyDto(myname, mytitle, mycontent));
		
		if(res > 0) {
	%>
	<script type="text/javascript">
	alert("작성성공");
	location.href="boardmain.jsp";
	</script>
	<%
		} else{
	%>
	<script type="text/javascript">
	alert("작성싪패");
	location.href="boardinsert.jsp";
	</script>
	<%
		}
	%>
</body>
</html>