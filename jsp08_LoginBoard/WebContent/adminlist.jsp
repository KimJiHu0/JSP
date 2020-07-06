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
<title>회원 전체출력</title>
</head>
<body>

<%
	List<MyDto> list = (List<MyDto>)request.getAttribute("list");
%>
	<h1>회원 전체출력(Admin)</h1>
	
	
	<table border="1">
		<tr>
			<th>No</th>
			<th>ID</th>
			<th>PW</th>
			<th>Name</th>
			<th>ADDR</th>
			<th>Phone</th>
			<th>E-mail</th>
			<th>Enabled</th>
			<th>Role</th>
		</tr>
		
		<%
			for(int i = 0; i < list.size(); i++){
		%>
			<tr>
				<td><%=list.get(i).getMyno() %></td>
				<td><%=list.get(i).getMyid() %></td>
				<td><%=list.get(i).getMypw() %></td>
				<td><%=list.get(i).getMyname() %></td>
				<td><%=list.get(i).getMyaddr() %></td>
				<td><%=list.get(i).getMyphone() %></td>
				<td><%=list.get(i).getMyemail() %></td>
				<td><%=list.get(i).getMyenabled() %></td>
				<td><%=list.get(i).getMyrole() %></td>
			</tr>
		<%
			}
		%>
	</table>
</body>
</html>