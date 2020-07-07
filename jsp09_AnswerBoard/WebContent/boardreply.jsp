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
	<h1>답글달기</h1>
	
	<form action="controller.do" method="get">
	<input type="hidden" name="command" value="replyRes"/>
	<input type="hidden" name="boardno" value="${dto.boardno}"/>
	<table border="1">
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" value="RE:${dto.title}" autofocus="autofocus"/>
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" name="writer"/>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="60" name="content">${dto.content}</textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="완료"/>
				<input type="button" value="취소" onclick="location.href='controller.do?command=detail&boardno=${dto.boardno}'"/>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>