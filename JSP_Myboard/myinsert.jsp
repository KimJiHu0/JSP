<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; cahrest=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>글쓰기</h1>

	<!-- 보안이 필요한 방식 : post ! 가려서 보내주니까 -->
	<form action="myinsertres.jsp" method="post">
		<table border="1">
			<tr>
				<th>이름</th>
				<!-- name이라는게 쿼리스트링의 key값이 된다. -->
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
					<input type="button" value="취소"/>
					<input type="submit" value="입력"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>