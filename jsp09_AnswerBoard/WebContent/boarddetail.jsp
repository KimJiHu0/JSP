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
<!-- jspBeans를 사용했다. id는 dtoㅣㅇ고 class는 아래에 있는 경로를 넣어줬다. -->
<jsp:useBean id="dto" class="com.answer.model.dto.AnswerDto" scope="request"></jsp:useBean>
	<h1>글 상세보기</h1>
	
	<table border="1">
		<tr>
			<th>작성자</th>
			<td>
				<jsp:getProperty property="writer" name="dto" />
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<jsp:getProperty property="title" name="dto"/>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="60" readonly="readonly"><jsp:getProperty property="content" name="dto"/></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" value="목록" onclick="location.href='controller.do?command=boardlist'"/>
				<input type="button" value="수정" onclick="location.href='controller.do?command=boardupdate&boardno=${dto.boardno}'"/>
				<input type="button" value="답변" onclick="location.href='controller.do?command=reply&boardno=${dto.boardno}'"/>
				<input type="button" value="삭제" onclick="location.href='controller.do?command=delete&boardno=${dto.boardno}'"/>
			</td>
		</tr>
	</table>
</body>
</html>