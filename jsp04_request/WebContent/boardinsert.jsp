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
<title>글 작성</title>
</head>
<body>

	<h1>글 작성</h1>
<!-- 
[ 7. ] boardcontroller.jsp에서 요청한 page인 boardinsert.jsp이다.
이 곳에서는 글작성을 하는 table을 만들고 글 작성 후에 완료버튼을 누르면 이 값을을 처리해줄 것이다.
먼저 form태그에 action속성을 작성하고 controller.jsp를 적어준다.
action속성을 적는 이유는 submit이벤트가 발생했을 때 form태그 안에있는 모든 값들을 가지고 controller.jsp로
넘어가기 때문이다.
그래서 이름,제목,내용 안에 작성하는 input,textarea 태그들의 name 속성을 붙여주었다.
작성을 다 했으면 command값인 insertRes와 다같이 넘어간다.
insertRes는 type이 hidden이기 때문에 보이지 않지만 값은 같이 전달된다.
 -->
	<form action = "boardcontroller.jsp">
	<input type = "hidden" name="command" value="insertRes"/>
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
					<input type="submit" value="작성완료"/>
					<input type="button" value="취소하기" onclick="location.href='boardcontroller.jsp?command=list'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>