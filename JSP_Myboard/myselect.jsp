<%@page import="com.my.dto.MyBoardDto"%>
<%@page import="com.my.dao.MyBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<% request.setCharacterEncoding("UTF-8"); %>
	<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//들어오는 값(myno)이 문자열이기 때문에 숫자형으로 바꿔준다,
	//request.getParameter("querystring key값") : key값에 해당하는 value값을 꺼내올 수 있다.
	int myno = Integer.parseInt(request.getParameter("myno"));

	//db에서  값 넘어가는거
	//자바랑 db랑 연결하기위해 dao를 만들었다 (jdbc)
	//dao는 db랑 연결하기 위한 객체
	MyBoardDao dao = new MyBoardDao();
	//db랑 연결해서 myno와 맞는 값 하나의 row를 가져와서 dto에 담고 담아진 값을 리턴.
	MyBoardDto dto = dao.selectOne(myno);

	//위의 것들은 그저 객체이다. 값을 담아주는 객체.
	%>
	<h1>글 상세보기</h1>

	<table border = "1">
		<tr>
			<th>이름</th>
			<td><%= dto.getMyname() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%= dto.getMytitle() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows = "10" cols="60" readonly="readonly"><%=dto.getMycontent() %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
			<!-- 1. 수정이라는 버튼을 눌렀을 때 dto에서 myno라는 번호를 가지고 myupdate라는 jsp파일로 이동한다. -->
				<input type="button" value="수정" onclick="location.href='myupdate.jsp?myno=<%=dto.getMyno()%>'"/>
				<input type="button" value="삭제" onclick="location.href='mydelete.jsp?myno=<%=dto.getMyno()%>'"/>
				<input type="button" value="목록" onclick="location.href='mylist.jsp'"/>
			</td>
		</tr>
	</table>

</body>
</html>