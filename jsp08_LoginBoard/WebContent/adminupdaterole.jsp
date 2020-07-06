<%@page import="com.my.dto.MyDto"%>
<%@page import="java.util.List"%>
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
	MyDto dto = (MyDto)request.getAttribute("dto");
%>
	<h1>회원 등급 변경 페이지</h1>
	
	<form action="controller.jsp" method="get">
	<input type="hidden" name="command" value="updateroleRes"/>
	<input type="hidden" name="myno" value="<%=dto.getMyno() %>"/>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>등급</th>
		</tr>
		<tr>
			<td><%=dto.getMyno() %></td>
			<td><%=dto.getMyname() %></td>
			<td>
				<select name="myrole">
					<!-- 나의 등급이 user이라면 selected속성을 주고 아니라면 그대로 냅둔다. -->
					<option value="USER" <%=dto.getMyrole().equals("USER")?"selected" : "" %>>일반회원</option>
					<!-- 나의 등급이 admin이라면 selected속성을 주고 아니라면 그대로 냅둔다. -->
					<option value="ADMIN" <%=dto.getMyrole().equals("ADMIN")?"selected" : "" %>>관리자</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="3" align="right">
				<input type="submit" value="변경완료"/>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>