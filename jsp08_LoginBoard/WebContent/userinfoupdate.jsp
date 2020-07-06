<%@page import="com.my.dto.MyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
<%
	//controller.jsp에서 보내준 결과값을 받아온다.
	MyDto dto = (MyDto)request.getAttribute("dto");
%>
	<h1>User Information Update</h1>
	
	<!-- 
	form태그 안에서 name과 input text를 주면서 수정을 할 수 있게 만들었고
	수정을 다 한후에 update버튼을 클릭할 시 command값은 userinfoupdateRes이고
	myno값을 같이 보냈다.
	 -->
	<form action="controller.jsp" method="get">
	<input type="hidden" name="command" value="userinfoupdateRes"/>
	<input type="hidden" name="myno" value="<%=dto.getMyno() %>"/>
		<table border="1">
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
				<td>
					<input type="text" name="mypw" value="<%=dto.getMypw() %>"/>
				</td>
			</tr>
			<tr>
				<th>Name</th>
				<td>
					<input type="text" name="myname" value="<%=dto.getMyname() %>"/>
				</td>
			</tr>
			<tr>
				<th>Address</th>
				<td>
					<input type="text" name="myaddr" value="<%=dto.getMyaddr() %>"/>
				</td>
			</tr>
			<tr>
				<th>PhoneNumber</th>
				<td>
					<input type="text" name="myphone" value="<%=dto.getMyphone() %>"/>
				</td>
			</tr>
			<tr>
				<th>E-mail</th>
				<td>
					<input type="text" name="myemail" value="<%=dto.getMyemail() %>"/>
				</td>
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
					<input type="button" value="Cancel" onclick="location.href='controller.jsp?command=userinfo&myno=<%=dto.getMyno()%>'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>