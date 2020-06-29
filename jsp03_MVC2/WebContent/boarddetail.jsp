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
<title>글 상세보기</title>
<style type="text/css">
#updateform{
	display : none;
}
</style>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
function updateFormView(){
	$("#detailform").hide();
	$("#updateform").show();
}
function detailFormView(){
	$("#detailform").show();
	$("#updateform").hide();
}
</script>
</head>
<body>
	<%
	//boardcontroller.jsp에서 이름을 dto라고 지정했다 selectOne한 값들을 받은 것이다.
	//request.getAttribute("dto");이 부분에 어떠한값이 담길지 몰라서
	//가장 큰 값인 MVCdto로 명시적 형 변환을 해주었다. 그래야 사용할 수 있다.
	//boardcontroller.jsp에서 넘겨준 값. [request에 dto를 넣었는데 그 이름을 dto라고 칭했다.]
	//그리고 이름이 dto인 것을 찾아서 가져온 후에 MVCdto dto라는 객체에 넣어준다.
	MVCdto dto = (MVCdto)request.getAttribute("dto");
	%>

	<div id="detailform">
		<h1>글 상세보기</h1>

		<table border="1">
			<tr>
				<th>이름</th>
				<td><%=dto.getMyname()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getMytitle()%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" readonly="readonly"><%=dto.getMycontent()%></textarea></td>
			</tr>
			<tr>
				<td colspan="3" align="right">
					<input type="button" value="수정" onclick="updateFormView();" />
					<input type="button" value="삭제"
					onclick="location.href='boardcontroller.jsp?command=delete&myno=<%=dto.getMyno()%>'" />
					<input type="button" value="목록"
					onclick="location.href='boardcontroller.jsp?command=list'" /></td>
			</tr>
		</table>
	</div>

	<div id="updateform">
	<h1>글수정</h1>
	<form action="boardcontroller.jsp" method="post">
	<input type="hidden" name="command" value="update"/>
	<input type="hidden" name="myno" value="<%=dto.getMyno() %>"/>
		<table border="1">
			<tr>
				<th>이름</th>
				<td><input type="text" readonly="readonly" value="<%=dto.getMyname()%>"/></td>
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
				<td colspan="3" align="right">
					<input type="button" value="취소" onclick="detailFormView();"/>
					<input type="submit" value="수정"/>
					<input type="button" value="목록" onclick="location.href='boardcontroller.jsp?command=list'"/>
				</td>
			</tr>
		</table>
	</form>
	
	</div>
</body>
</html>