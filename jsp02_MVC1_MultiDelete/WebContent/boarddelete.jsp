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
		int myno = Integer.parseInt(request.getParameter("myno"));
		
		MyDao dao = new MyDao();
		int res = dao.delete(myno);
		
		if(res > 0){
	%>
	<script type="text/javascript">
	alert("삭제 성공");
	location.href="boardmain.jsp";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
	alert("삭제 실패");
	location.href="boardselectone.jsp?myno=<%=myno%>";
	</script>
	<%
		}
	%>
</body>
</html>