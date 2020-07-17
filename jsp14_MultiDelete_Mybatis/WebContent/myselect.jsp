<%@page import="com.my.model.dto.MyDto"%>
<%@page import="com.my.model.dao.MyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	textarea{
		resize : none;
	}
</style>
</head>
<body>
	<%
		int myno = Integer.parseInt(request.getParameter("myno"));
	MyDao dao = new MyDao();
	MyDto dto = dao.selectOne(myno);
	%>
	<table border = "1">
		<tr>
			<th>작성자</th>
			<td><%=dto.getMyname() %></td>
		</tr>
		<tr>
			<th>제  목</th>
			<td><%=dto.getMytitle() %></td>
		</tr>
		<tr>
			<th>내  용</th>
			<td><textarea rows="10" cols="60" readonly="readonly"><%=dto.getMycontent() %></textarea></td>
		</tr>
		<tr>
			<td colspan = "2" align="right">
				<input type="button" value="돌아가기" onclick="location.href='mainboard.jsp'"/>
				<input type="button" value="수정하기" onclick="location.href='myupdate.jsp?myno=<%=myno%>'"/>
				<input type="button" value="삭제하기" onclick="location.href='mydelete.jsp?myno=<%=myno%>'"/>
			</td>
		</tr>
	</table>
</body>
</html>