<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
	<!-- 해당 href의 controller.do를 찾는다. xml파일로 가보면 controller.do를 입력했을 때 controller servlet로 가라고 명시어있다. -->
	<a href="controller.do?command=list">게시판으로 갑시다아</a>
</body>
</html>