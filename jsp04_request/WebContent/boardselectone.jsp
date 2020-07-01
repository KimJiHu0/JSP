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
<title>글 상세보기</title>
</head>
<body>
	<%
	/*
	[ 11. ]boardcontroller.jsp에서 biz.selectone실행 결과값을 담은 selectone을  getAttribute로 받아와야한다.
	이 역시 selectone에 무슨 값이 들어갈지 모르기 때문에 MyDto라고 명시적으로 형 변환을 해주어야한다.
	*/
		MyDto dto = (MyDto) request.getAttribute("selectone");
	%>
	<h1>글 상세보기</h1>
	<!-- 
	[ 12. ]사실 form태그로 작성할 필요가 없다.상세보기창인 boardselectone에서 수정을 누를 떄는 그냥 이 값을 가져가면
	되는데 나는 실수로 만든것같다.. ㅎㅎㅎ
	여튼 form태그로 작성했기 때문에 현재 table안에 작성된 name들을 모두 submit 이벤트가 발생할 시에 boardcontroller.jsp
	로 넘어가게 된다. name이 command와 myno는 hidden이라 화면에는 보이지 않지만 같이 넘어간다.
	 -->
<form action = "boardcontroller.jsp" method="post">
<input type="hidden" name="command" value="update"/>
<input type="hidden" name="myno" value="<%=dto.getMyno()%>"/>
	<table border = "1">
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
			<td><textarea rows="10" cols="60"readonly="readonly"><%=dto.getMycontent() %></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
			<!-- 
			[ 13. ]목록이라는 버튼을 누르면 onclick이벤트가 발생하는데 이는 boardcontroller.jsp로 가는데 command는 list를 가지고가라는 의미다.
			만일 command가 list라면 controller.jsp에서 작성한 if문에서 일치해서 실행되어 boardmain.jsp로 넘어갈 것이다.
			
			[ 18. ] 삭제 버튼을 누르게 되면 onclick이벤트가 발생하여 boardcontroller.jsp로 command값은 delete를 가지고 간다.
			 -->
				<input type="button" value="목록" onclick="location.href='boardcontroller.jsp?command=list'"/>
				<input type="submit" value="수정"/>
				<input type="button" value="삭제" onclick="location.href='boardcontroller.jsp?command=delete&myno=<%=dto.getMyno()%>'"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>