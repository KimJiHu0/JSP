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
<title>글 상세보기</title>
</head>
<body>
<!-- controller에서 setAttribute에서 지정해준 이름으로 id를 적어주어야한다.
그리고 이 객체는 page -> request -> session -> application을 차례로
들러서 dto라는 이름의 request가 있는지 찾는다. -->
	<jsp:useBean id="dto" class="com.dto.MyDto" scope="request"></jsp:useBean>

	<table border="1">
		<tr>
			<th>이름</th>
			<td>
				<jsp:getProperty property="writer" name="dto"/>
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
			<td>
				<textarea rows="10" cols="60" readonly="readonly"><jsp:getProperty property="content" name="dto"/></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" value="목록" onclick="location.href='controller.do?command=list'"/>
				<input type="button" value="수정" onclick="location.href='controller.do?command=update&seq=${dto.seq}'"/>
				<input type="button" value="삭제" onclick="location.href='controller.do?command=detele&seq=${dto.seq}'"/>
			</td>
		</tr>
	</table>
</body>
</html>