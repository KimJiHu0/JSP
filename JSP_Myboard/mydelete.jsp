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
	<!--  -->
	<%
	int myno = Integer.parseInt(request.getParameter("myno"));
	MyBoardDao dao = new MyBoardDao();
	int res = dao.delete(myno);
	
	//삭제를 성공했다면
	if(res > 0) {
	%>
	<script type="text/javascript">
		alert("삭제 성공하였습니다.");
		location.href="mylist.jsp";
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
		alert("삭제에 실패했습니다.");
		location.href="mylist.jsp";
	</script>
	<%
	}
	%>
</body>
</html>