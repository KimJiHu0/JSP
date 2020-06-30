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
<title>글 상세보기</title>
</head>
<body>
	<%
	//제목을 클릭했을 때 a태그가 실행되면서 넘어온 페이지인데 넘어올 때 값을 같이 주었다.
	//클릭한 글에 해당하는 myno를 넘겨주었는데 이를 받아왔다.
	int myno = Integer.parseInt(request.getParameter("myno"));
	
	//dao를 사용할 수 있게 객체를 생성해주고
	MyDao dao = new MyDao();
	//dao에 selectOne이라는 메소드를 myno아규먼트를 넣어 사용을 한 후에 dto에 담아주었다.
	//이렇게 되면 내가 클릭한 글에 해당하는 컬럼들이 가져와진다.
	MyDto dto = dao.selectOne(myno);
	%>
	<h1>글 상세보기</h1>
	<table border="1">
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
			<td><textarea rows="10" cols="60" readonly="readonly"><%=dto.getMycontent() %></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="button" value="목록" onclick="location.href='boardmain.jsp'"/>
				<!-- 
				수정버튼을 클릭했을 때 boardupdate.jsp로 갈 것인데
				?myno라는 의미는 myno라는 값을 가져갈거라는 뜻이다. 현재 내가 보고 있는 이 상세보기한 글의 myno값을 가지고간다.
				이유는 내가 이 상세보기에서 수정을 눌렀을 때 이 값들을 그대로 가지고가야하기 때문에 이 글에 대한 myno값을 가지고 간다.
				 -->
				<input type="button" value="수정" onclick="location.href='boardupdate.jsp?myno=<%=myno%>'"/>
				<input type="button" value="삭제" onclick="location.href='boarddelete.jsp?myno=<%=myno%>'"/>
			</td>
		</tr>
	</table>
</body>
</html>