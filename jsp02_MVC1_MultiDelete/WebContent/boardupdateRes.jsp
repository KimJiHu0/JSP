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
		
		//boardupdate.jsp에서 수정을 하고 넘겨준 값을 받아와야한다. 기본적으로 hidden한 myno값도 가져온다.
		int myno = Integer.parseInt(request.getParameter("myno"));
		String mytitle = request.getParameter("mytitle");
		String mycontent = request.getParameter("mycontent");
		
		//dao를 사용하기 위한 객체생성
		MyDao dao = new MyDao();
		//update에 성공한 갯수를 받기위해 int형 res변수 선언해주고
		//dto에서 파라미터3개짜리 생성자를 사용했고 update의 아규먼트로 넣어주었으며 dao에 있는 update
		//메소드를 사용하여 값을 담아줬다.
		int res = dao.update(new MyDto(myno, mytitle, mycontent));
		
		if(res > 0) {
	%>
	<script type="text/javascript">
	alert("수정 성공");
	location.href="boardselectone.jsp?myno=<%=myno%>";
	</script>
	<%
		} else{
	%>
	<script type="text/javascript">
	alert("수정실패");
	location.href="boardupdate.jsp?myno=<%=myno%>";
	</script>
	<%
		}
	%>
</body>
</html>