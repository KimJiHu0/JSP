<%@page import="com.dto.MyDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성 페이지</title>
</head>
<body>
<%
	/*
		[ 3. ]boardcontroller.jsp에서 setAttribute로 결과값을 담은 request객체를 list라는 이름으로
		보내주었다. 그럼 이 boardmain.jsp에서는 보내준 값을 받아야한다.
		타입은 List배열이고, set으로 보냈기 때문에 get으로 받아온다.
		이렇게만 작성할 경우 오류가 난다.
		왜냐면 "list"라는 이름을 가진 객체를 가져오긴 했는데 어떤 타입의 객체인지는 알 수가 없다.
		그러니가 명시적으로 무슨타입인지 정의를 해줘야한다.
	*/
	List<MyDto> list = (List<MyDto>)request.getAttribute("list");
%>
	<h1>글 목록</h1>
	
	<table border="1">
	<col width = "80"/>
	<col width = "80"/>
	<col width = "200"/>
	<col width = "100"/>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>제목</th>
			<th>날짜</th>
		</tr>
		
		<%
			/*
				[ 4. ]for문을 돌릴 것이다. list에 담겨있는 dto한줄한줄을 왼쪽에 명시된 dto에 담을 것이다.
				만일 list에 row가 3개가 있다면 3개의 dto가 담기는 셈이다.
				0번지에 있는 dto의 myno, myname, mytitle, mydate를 출력하고
				1번지에 있는 dto의 myno.... 을 출력하고 마지막에 있는 것까지 출력을 한다.
			*/
			for(MyDto dto : list){
		%>
			<tr>
				<td><%=dto.getMyno() %></td>
				<td><%=dto.getMyname() %></td>
				<!-- 
				[ 9. ] 제목를 a태그로 감쌌다.이제 제목을 클릭하면 링크를 걸어줄 수 있는데. 링크를 클릭하게 되면 boardcontroller.jsp로
				간다. 가면서 command값은 selectone을 가져가고 그와 같이 클릭한 해당 페이지의 myno값도 같이 가져가준다.
				이유는 dao에서 selectone메소드는 파라미터를 int myno값을 받는다. 내가 선택한 제목의 int myno이기 떄문에
				같이 가져가 준다.
				 -->
				<td><a href="boardcontroller.jsp?command=selectone&myno=<%=dto.getMyno()%>"><%=dto.getMytitle() %></a></td>
				<td><%=dto.getMydate() %></td>
			</tr>
		<%
			}
		%>
		<tr>
			<td colspan="4" align = "center">
			<!-- 
			[ 5. ] 위의 list들을 다 만들어준 후에는 글작성이라는 버튼을 클릭하면 boardcontroller.jsp로 가는데 command값을 insert를 가지고 간다.
			 -->
				<input type="button" value="글 작성" onclick="location.href='boardcontroller.jsp?command=insert'"/>
			</td>
		</tr>
	</table>
</body>
</html>