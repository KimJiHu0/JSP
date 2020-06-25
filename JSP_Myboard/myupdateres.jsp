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
//6. 여기서는 update에서 전달한 값들을 하나씩 다 받아주었다.
	int myno = Integer.parseInt(request.getParameter("myno"));
	String myname = request.getParameter("myname");
	String mytitle = request.getParameter("mytitle");
	String mycontent = request.getParameter("mycontent");
	MyBoardDto dto = new MyBoardDto(myno, null, mytitle, mycontent, null);
	//객체를 생성해주고
	MyBoardDao dao = new MyBoardDao();
	
	//dao의 메서드를 사용하기 위해서 객체를 가져온 것.
	
	//dao에서 일처리를 하는데 res에 리턴된 갯수를 반환한다.
	int res = dao.update(dto);
	
	//성공했따면 ㅇㅇ
	if(res > 0){
%>
	<script type="text/javascript">
		alert("수정 ㅇ");
		location.href="mylist.jsp";
	</script>
<%
	//실패했따면
	} else {
%>
	<script type="text/javascript">
		alert("수정 x");
		location.href="myupdate.jsp?myno=<%=myno%>";
	</script>
<%
	}
%>

</body>
</html>