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
<title>글 수정</title>
</head>
<body>
	<!-- 아래의 구문은 request타입?의 객체를 찾아 이름이 dto인 것을 사용하겠다는 의미로 받아들여도 좋다. -->
	<jsp:useBean id="dto" class="com.dto.MyDto" scope="request"></jsp:useBean>
	<h1>글 수정</h1>

	<form action="controller.do">
	<input type="hidden" name="command" value="updateRes"/>
	<input type="hidden" name="seq" value="<jsp:getProperty property='seq' name='dto'/>"/>
		<table border="1">
			<tr>
				<th>이름</th>
				<td>
					<!-- get을 이용해서 값들을 가져온다. -->
					<jsp:getProperty property="writer" name="dto"/>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" value="<jsp:getProperty property='title' name='dto'/>"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="content"><jsp:getProperty property="content" name="dto"/></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정완료"/>
					<input type="button" value="돌아가기" onclick="location.href='controller.do?command=detail&seq=${dto.seq}'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>