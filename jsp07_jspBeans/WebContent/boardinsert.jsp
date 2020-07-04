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
	<h1>글 작성</h1>

	<!--작성완료를 누르게되면 form태그 안의 모든 값들이 controller.do를 찾아 Servlet로 간다. -->
	<form action="controller.do">
	<input type="hidden" name="command" value="insertRes"/> 
		<table border="1">
			<tr>
				<th>작성자</th>
				<td><input type="text" name="writer"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="작성완료"/>
					<input type="button" value="목록보기" onclick="location.href='controller.do?command=list'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>