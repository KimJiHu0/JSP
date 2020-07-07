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
	<h1>글 작성</h1>
	
	<form action="controller.do">
	<input type="hidden" name="command" value="insertRes"/>
	<table border="1">
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" name="writer" placeholder="이름을 입력하세요"/>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" placeholder="제목을 입력하세요"/>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="10" cols="60" name="content" placeholder="내용을 입력하세요"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" value="목록" onclick="location.href='controller.do?command=boardlist'"/>
				<input type="submit" value="작성완료"/>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>