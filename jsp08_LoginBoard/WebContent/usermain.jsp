<%@page import="com.my.dto.MyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
</head>
<body>
<%
	MyDto dto = (MyDto)session.getAttribute("dto");
%>
<!-- Role가 user이기 때문에 usermain.jsp로 왔다 -->
<!-- 내 정보보기를 클릭했을 때 controller.jsp로 command값을 userinfo을 가지고 간다. -->
	<h1><%=dto.getMyname() %>님 환영합니다!</h1>
	
	등급 : <%=dto.getMyrole() %>
	<br/>
	<a href="controller.jsp?command=logout">logout</a>
	<br/>
	<!-- 내정보보기를 클릭할 시에 controller.jsp로 가는데 command값은 userinfo이고 기본값인 번호를 가지고 간다. -->
	<a href="controller.jsp?command=userinfo&myno=<%=dto.getMyno() %>">내 정보보기</a>
	
</body>
</html>