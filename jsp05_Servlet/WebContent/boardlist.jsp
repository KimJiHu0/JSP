-<%@page import="com.mvc.dto.MVCBoardDto"%>
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
	List<MVCBoardDto> list = (List<MVCBoardDto>)request.getAttribute("list");
MVCBoardDto dto = new MVCBoardDto();
%>

<table border="1">
<col width="50"/>
<col width="100"/>
<col width="300"/>
<col width="100"/>
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>제목</th>
		<th>날짜</th>
	</tr>
	<%
		for(int i = 0; i < list.size(); i++) {
	%>
	<tr>
		<td><%=list.get(i).getMyno() %></td>
		<td><%=list.get(i).getMyname() %></td>
		<td><a href="controller.do?command=selectone&myno=<%=list.get(i).getMyno()%>"><%=list.get(i).getMytitle() %></a></td>
		<td><%=list.get(i).getMydate() %></td>
	</tr>
	<%
		}
	%>
	<tr>
		<td colspan="4" align="right">
		<input type="button" value="글작성하기" onclick="location.href='controller.do?command=insert'"/>
		</td>
	</tr>
</table>

</body>
</html>