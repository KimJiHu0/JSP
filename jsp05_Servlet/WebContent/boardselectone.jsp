<%@page import="com.mvc.dao.MVCBoardDao"%>
<%@page import="com.mvc.dto.MVCBoardDto"%>
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
	<%
		MVCBoardDto dto = (MVCBoardDto) request.getAttribute("select");
	%>

	<form action="controller.do?"method="post">
		<input type="hidden" name="command" value="update"/>
		<input type="hidden" name="myno" value="<%=dto.getMyno() %>"/>
		<table border="1">
			<tr>
				<th>이름</th>
				<td><%=dto.getMyname() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getMytitle() %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" readonly="readonly"><%=dto.getMycontent() %></textarea></td>
			</tr>
			<tr>
				<td colspan = "2" align = "right">
					<input type="button" value="목록"/>
					<input type="submit" value="수정"/>
					<input type="button" value="삭제" onclick="location.href='controller.do?command=delete&myno=<%=dto.getMyno()%>'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>