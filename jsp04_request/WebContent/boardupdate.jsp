<%@page import="com.dto.MyDto"%>
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
	<%
	/*
	[ 15. ] biz.selectOne()을 실행한 결과값을 담은 updateselect를 getAttribute로 받아주되
	updateselect에 무슨 값이 들어올지 모르기 때문에 명시적으로 MyDto타입이라는것 작성해주어야한다.
	그 가져온 값을 dto에 넣었다.
	*/
		MyDto dto = (MyDto) request.getAttribute("updateselect");
	%>
	<h1>글 수정하기</h1>

<!-- 
[ 16. ]이 jsp는 boardselect.jsp에서 수정을 누르면 이름을 제외한 나머지인 제목과 내용을 수정할 수 있게 만들었고,
그 수정한 값을 form태그로 전달해줄 수 있게 만들었다.
이름과 제목 내용에 name속성을 준다. 그리고 새로운 값으로 수정하여 작성한다음에 수정완료를 누르면 submit이벤트가 발생하게 된다.
submit이벤트가 발생하면서 form태그에 있는 action이 실행되고 form태그 안에있는 모든 값들을 boardcontroller.jsp로
가지고 가게 된다.
 -->
	<form action="boardcontroller.jsp" method="post">
	<input type="hidden" name="command" value="updateRes"/>
	<input type="hidden" name="myno" value="<%=dto.getMyno() %>"/>
		<table border = "1">
			<tr>
				<th>이름</th>
				<td><input type="text" name="myname" readonly="readonly" value="<%=dto.getMyname() %>"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="mytitle" value="<%=dto.getMytitle()%>"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="mycontent"><%=dto.getMycontent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정완료"/>
					<input type="button" value="취소하기" onclick="location.href='boardcontroller.jsp?command=selectone&myno=<%=dto.getMyno()%>'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>