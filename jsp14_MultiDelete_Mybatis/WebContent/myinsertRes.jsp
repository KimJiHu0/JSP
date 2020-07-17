<%@page import="com.my.model.dto.MyDto"%>
<%@page import="com.my.model.dao.MyDao"%>
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
	String myname = request.getParameter("myname");
String mytitle = request.getParameter("mytitle");
String mycontent = request.getParameter("mycontent");

MyDao dao = new MyDao();
int res = dao.insert(new MyDto(0, myname, mytitle, mycontent, null));

if(res > 0) {
%>
<script type="text/javascript">
	alert("추가에 성공했습니다.");
	location.href="mainboard.jsp";
</script>
<%
} else {
%>
<script type="text/javascript">
	alert("추가에 실패했습니다.");
	location.href="myinsert.jsp";
</script>
<%
}
%>

</body>
</html>