<%@page import="com.my.dto.MyDto"%>
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
	//controller.jsp에서 처리한 결과값을 보냈다. 이를 getAttribute로 받아준다.
		MyDto dto = (MyDto)request.getAttribute("dto");
	%>
	<h1>User Information</h1>
	
	<!-- Update버튼을 클릭했을 때 수정을 할수있는 페이지로 이동하게 된다. 이때 form태그 안의 name값들을 모두 가져가고 -->
	<!-- command값을 userinfoupdate라는 값을 가지고 가며 myno값을 가지고간다. -->
	<form action="controller.jsp" method="get">
	<input type="hidden" name="command" value="userinfoupdate"/>
	<input type="hidden" name="myno" value="<%=dto.getMyno()%>"/>
	<table border = "1">
		<tr>
			<th>No</th>
			<td><%=dto.getMyno() %></td>
		</tr>
		<tr>
			<th>ID</th>
			<td><%=dto.getMyid() %></td>
		</tr>
		<tr>
			<th>Password</th>
			<td><%=dto.getMypw() %></td>
		</tr>
		<tr>
			<th>Name</th>
			<td><%=dto.getMyname() %></td>
		</tr>
		<tr>
			<th>Address</th>
			<td><%=dto.getMyaddr() %></td>
		</tr>
		<tr>
			<th>PhoneNumber</th>
			<td><%=dto.getMyphone() %></td>
		</tr>
		<tr>
			<th>E-mail</th>
			<td><%=dto.getMyemail() %></td>
		</tr>
		<tr>
			<th>Enabled</th>
			<td><%=dto.getMyenabled() %></td>
		</tr>
		<tr>
			<th>Role</th>
			<td><%=dto.getMyrole() %></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="Update"/>
				<input type="button" value="Back" onclick="location.href='usermain.jsp?myno=<%=dto.getMyno()%>'"/>
				<input type="button" value="Leave" onclick="location.href='controller.jsp?command=Leave&myno=<%=dto.getMyno()%>'"/>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>