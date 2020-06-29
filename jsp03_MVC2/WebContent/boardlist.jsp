<%@page import="com.dto.MVCdto"%>
<%@page import="java.util.List"%>
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
//컨트롤러에서 넘겨준 값 담아주기.
//(List<MVCdto>)로 형변환을 해주어야한다.
//무슨값이 들어올지 모르기 때문에 일단 제일 큰 object타입으로 명시적 형변환을 실행한다.
List<MVCdto> list = (List<MVCdto>)request.getAttribute("list");
%>

<h1>글목록</h1>

<table border="1">
	<col width="50" />
	<col width="100" />
	<col width="300" />
	<col width="100" />
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>제목</th>
		<th>작성일</th>
	</tr>
	<%
	//list에 아무 값도 들어있지 않다면
	if(list.size() == 0){
	%>
	<td colspan="4"> 작성된 글이 없습니다. </td>
	<%
	//그렇지 않고 글이 하나라도 있다면
	} else {
		//list에 있는걸 dto에 담아준다.
		for(MVCdto dto : list) {
	%>
	<tr>
		<td><%=dto.getMyno() %></td>
		<td><%=dto.getMyname() %></td>
		<td><a href="boardcontroller.jsp?command=detail&myno=<%=dto.getMyno()%>"><%=dto.getMytitle() %></a></td>
		<td><%=dto.getMydate() %></td>
	</tr>
	<%
		}
	}
	%>
	<tr>
		<td colspan="4" align = "right">
		<!-- boardcontroller.jsp로 넘길 때 command값을 insert라 하고 넘겨주었다. -->
			<input type="button" value="글 작성" onclick="location.href='boardcontroller.jsp?command=insert'"/>
		</td>
	</tr>
</table>

</body>
</html>