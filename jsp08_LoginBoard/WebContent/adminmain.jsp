<%@page import="com.my.dto.MyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
</head>
<body>
<%
MyDto dto = (MyDto)session.getAttribute("dto");
%>
	<h1>관리자  페이지</h1>
	
	<%=dto.getMyname() %>님 환영합니다.
	<br/>
	등급 : <%=dto.getMyrole() %>
	<br/>
	
	<a href="controller.jsp?command=logout">logout</a>
	<br/>
	<a href="controller.jsp?command=selectuserall">회원 전체출력</a>
	<br/>
	<a href="controller.jsp?command=selectenabled">회원 가입여부 출력(Enabled Y, N)</a>
</body>
</html>