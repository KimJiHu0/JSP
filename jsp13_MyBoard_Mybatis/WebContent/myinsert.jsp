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
<title>글 작성</title>
</head>
<body>
	<form action="myinsertres.jsp" method="post">
		<table border="1">
			<tr>
				<th>이름</th>
				<td><input type="text" name="myname"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="mytitle"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="mycontent"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="button" value="취소" onclick="location.href='mylist.jsp'"/>
					<input type="submit" value="글 작성"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>