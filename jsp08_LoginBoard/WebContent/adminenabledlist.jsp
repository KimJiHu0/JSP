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
	List<MyDto> list = (List<MyDto>)request.getAttribute("list");
%>

<table border="1">
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>주소</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th>가입여부</th>
		<th>등급</th>
		<th>등급변경</th>
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
			<td><input type="button" value="등급변경" onclick="location.href='controller.jsp?command=updaterole&myno=<%=list.get(i).getMyno()%>'"/></td>
		</tr>
	<%
		}
	%>
</table>

</body>
</html>