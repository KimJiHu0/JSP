<%@page import="com.dao.MyDao"%>
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
			boardselectone.jsp에서 수정버튼을 눌렀을 때 myno값을 가지고 넘어왔다.
			이를 받아주는 구문을 작성해준다.
			수정버튼을 눌러도 그 selectOne한 글을 가져와야하기 때문에
			selectOne메소드를 사용해준다.
			메소드를 사용하려면 dao객체를 만들어주고 이를 실행한 결과값을 dto에 담아주어야한다.
		*/
		int myno = Integer.parseInt(request.getParameter("myno"));
		MyDao dao = new MyDao();
		MyDto dto = dao.selectOne(myno);
	%>
<h1>글 수정하기</h1>
	<form action="boardupdateRes.jsp" method="get">
	<!-- type을 hidden으로 한 이유는 화면에 안보이게 하기 위해서. myno값을 가져가야하기 떄문에 작성 -->
	<input type="hidden" name="myno" value="<%=dto.getMyno()%>"/>
		<table border="1">
			<tr>
				<th>이름</th>
				<td><%=dto.getMyname() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="mytitle" value="<%=dto.getMytitle() %>"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" name="mycontent"><%=dto.getMycontent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정"/>
					<input type="button" value="취소" onclick="location.href='boardselectone.jsp?myno=<%=myno%>'"/>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>