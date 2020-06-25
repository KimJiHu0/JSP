<%@page import="com.my.dto.MyBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.my.dao.MyBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%request.setCharacterEncoding("UTF-8"); %>
    <%response.setContentType("text/html; charset=UTF-8"); %>
    <!-- 요청하는 객체의 데이터를 문자로 바꿔주자 -->
    <!-- 응답하는 타입은 텍스트/html이고 객체의 문자열은 UTF-8이다. -->
    <!-- 그 안에 들어가는게 java다 라는 것을 의미한다. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//값을 담아주는 객체.
	MyBoardDao dao = new MyBoardDao();
	List<MyBoardDto> list = dao.selectList();
%>
<body>
	<h1>List PAGE</h1>
	
	<table border="1">
		<col width="50px"/>
		<col width="100px"/>
		<col width="300px"/>
		<col width="100px"/>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>제목</th>
			<th>날짜</th>
		</tr>
		
		<% 
			//html안에 java가 들어가려면 <%사용해준다.
			for(int i = 0; i < list.size(); i++){
		%>
			<tr>
				<!-- java영역에 있는 값을 html의  영역에 넣어주겠다.
				java에서 가져온 값을 프린트해주는 역할 -->
				<td><%= list.get(i).getMyno()%></td>
				<td><%= list.get(i).getMyname()%></td>
				<!-- 값을 가져올 땐 ?로 key : value
				myselect.jsp에 값을 보낼건데 myno라는 값을 같이.
				title을 눌렀을 때 그에 해당하는 값 하나를 보내서 출력하기 위해 -->
				<td><a href="myselect.jsp?myno=<%= list.get(i).getMyno() %>"><%= list.get(i).getMytitle()%></a></td>
				<td><%= list.get(i).getMydate()%></td>
			</tr>
		<% 
			}
		%>
		<tr>
			<td colspan="4" align="right">
			<!-- location.href="" : 원하는 화면으로 이동해주는 기능. -->
				<input type="button" onclick="location.href='myinsert.jsp'" value="글 작성"/>
			</td>
		</tr>
	</table>
</body>
</html>