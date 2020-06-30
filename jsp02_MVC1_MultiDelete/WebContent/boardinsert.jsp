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
<title>글작성</title>
</head>
<body>

	<h1>글 작성하기</h1>
	<!-- 
	form태그 안에 action속성은 이 안에서 submit이벤트가 발생 했을때 해당 경로로 넘어가라는 의미다.
	이 때 넘어갈 때 input타입에 넣어준 name값을 가지고 넘어가게 된다.
	여기서 우리가 작성하기 위해 입력한 것들을 가져가서 그 페이지에서 name의 값으로 안에 입력한 값을 가져올 수 있다.
	name속성을 써주지 않으면 다른 페이지에서 이 값을 가져올 수 없기 떄문에 꼭 써주어야한다.
	 -->
	<form action="boardinsertRes.jsp">
		<table border="1">
			<tr>
				<th>이름</th>
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
					<input type="button" value="취소" onclick="location.href='boardmain.jsp'"/>
					<input type="submit" value="완료"/>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>