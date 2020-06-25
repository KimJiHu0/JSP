<%@page import="com.my.dto.MyBoardDto"%>
<%@page import="com.my.dao.MyBoardDao"%>
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

	<%
	//2. 문자열로 받아온 myno를 int형으로 변환하여 받아왔다.( 전 페이지에서 준 값 받았음. )
	int myno = Integer.parseInt(request.getParameter("myno"));
	
	//3. dao라는 객체를 생성하고
	MyBoardDao dao = new MyBoardDao();
	//dto에는 dao에 하나의 값을 update해야하기 때문에 기본값인 myno를, myno로 선택한 selectOne을 불러온다.
	MyBoardDto dto = dao.selectOne(myno);
	%>

	<h1>글 수정</h1>

	<form action="myupdateres.jsp" method="post">
		<input type="hidden" name="myno" value="<%=dto.getMyno()%>"/>
		<table border="1">
			<tr>
				<th>이름</th>
				<!-- 4. 이름의 값으로는 selectOne해서 가져온 name을 text에 담았고 -->
				<td><input type="text" name="myname"
					value="<%=dto.getMyname()%>" readonly="readonly" /></td>
			</tr>
			<tr>
				<th>제목</th>
				<!-- selectOne에서 가져온 title를 value값에 담고 -->
				<td><input type="text" name="mytitle"
					value="<%=dto.getMytitle()%>" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<!-- 내용 또한 selectOne에서 가져온 값을 담았다. -->
				<td><textarea rows="10" cols="60" name="mycontent"><%=dto.getMycontent()%></textarea></td>
			</tr>
			<tr>
			<!-- 번호로 가져와야하기 때문에 번호를 받아오는 것을 써주고 hidden해줬다. -->
				<!-- 확인을 누르면 form태그에서 action해준 myupdateres.jsp파일로 이동한다. -->
				<td>
					<input type="submit" value="확인" />
					<input type="button" value="취소" onclick="location.href='myselect.jsp?myno=<%=myno%>'"/>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>