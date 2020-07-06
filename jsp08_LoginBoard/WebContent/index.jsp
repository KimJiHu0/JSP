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
<title>홈화면</title>
</head>
<body>
	<h1>Login Page</h1>
	<!-- 로그인 페이지이다. 이곳에서 id와 pw를 입력하게 되면 controller로 넘어가서 로그인에 대한 것을 처리할 것이다. -->
	<form action="controller.jsp" method="get">
		<input type="hidden" name="command" value="login" />
		<table border="1">
			<tr>
				<th>I D :</th>
				<td><input type="text" name="myid" /></td>
			</tr>
			<tr>
				<th>P W :</th>
				<td><input type="text" name="mypw" /></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="login" />
					<input type="button" value="regist" onclick="location.href='controller.jsp?command=regist'"/>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>