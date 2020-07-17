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
<h1>글 작성하기</h1>
<form action ="myinsertRes.jsp" method="post">
	<table border="1">
		<tr>
			<th>작성자</th>
			<td><input type="text" name="myname" placeholder="이름을 입력하세요"/></td>
		</tr>
		<tr>
			<th>제  목</th>
			<td><input type="text" name="mytitle" placeholder="제목을 입력하세요"/></td>
		</tr>
		<tr>
			<th>내  용</th>
			<td><textarea rows="10" cols="60" name="mycontent" placeholder="내용을 입력하세요"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align = "right">
				<input type="button" value="취소하기" onclick="location.href='mainboard.jsp'"/>
				<input type="submit" value="작성완료"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>