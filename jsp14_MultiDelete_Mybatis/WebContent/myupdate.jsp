<%@page import="com.my.model.dto.MyDto"%>
<%@page import="com.my.model.dao.MyDao"%>
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
</head>
<body>
<%
int myno = Integer.parseInt(request.getParameter("myno"));

MyDao dao = new MyDao();
MyDto dto = dao.selectOne(myno);
%>
	<h1>글 수정하기</h1>

	<form action="myupdateRes.jsp" method="post">
	<input type="hidden" name="myno" value="<%=myno %>"/>
		<table border = "1">
			<tr>
				<th>작성자</th>
				<td><%=dto.getMyname() %></td>
			</tr>
			<tr>
				<th>제  목</th>
				<td><input type="text" name="mytitle" value="<%=dto.getMytitle() %>"/></td>
			</tr>
			<tr>
				<th>내  용</th>
				<td><textarea rows="10" cols="60" name="mycontent"><%=dto.getMycontent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align = "right">
					<input type="submit" value="수정완료"/>
					<input type="button" value="취소하기" onclick="location.href='myselect.jsp?myno=<%=myno%>'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>