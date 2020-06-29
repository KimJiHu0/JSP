<%@page import="com.biz.MVCbiz"%>
<%@page import="com.dto.MVCdto"%>
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
	<!-- 
	boardcontroller.jsp에서 page요청을 하여 이 페이지로 왔다.
	이 페이지에서는 글 작성을 하는 값들을 boardcontroller.jsp로 다시 넘겨주어야 한다.
	 -->
	<h1>글 작성</h1>
	<form action="boardcontroller.jsp" method="post">
	<!-- 3. 전체 값들의 command를 지정해주어야하기 때문에 type이 hidden인 input태그를 만들었다. -->
	<input type="hidden" name="command" value="insertRes"/>
		<table border="1">
			<tr>
				<th>이름</th>
				<!-- 
				1. 우리가 입력한 값을 boardcontroller.jsp로 보내주어야하기 때문에 input태그에
				name을 주어서 보내줄 수 있게 만들어준다.
				 -->
				<td><input type="text" name="myname" /></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="mytitle" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="mycontent"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<!-- 
				2. 작성완료를 누르게 되면 submit이벤트가 발생하면서 form태그 안에 action으로 지정해놓은 jsp로 간다.
				 -->
					<input type="submit" value="작성완료" />
					<input type="button" value="돌아가기" onclick="location.href='boardcontroller?command=list'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>