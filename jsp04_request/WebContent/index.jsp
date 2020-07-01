<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈</title>
</head>
<body>
<!-- [ 1. ] index에서 boardcontroller.jsp로 보냈다. command는 list라는 값을 가지고 보냈다. -->
	<a href="boardcontroller.jsp?command=list">게시판 홈</a>
</body>
</html>