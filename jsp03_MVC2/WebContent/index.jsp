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
	<!-- command는 내가 어떤 page에 가고 싶어하는지를 알려준다고 생각하면 된다.
	input태그에 name을 주듯 비슷한 거라고 생각하면 편하다. -->
	<a href="boardcontroller.jsp?command=list">list!</a>
</body>
</html>