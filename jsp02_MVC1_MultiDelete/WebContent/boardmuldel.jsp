<%@page import="com.dao.MyDao"%>
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
		//boardmain.jsp에서 체크된 애들을 받아온다는 의미이다.
	//평소와 다르게 String[]을 사용한 이유는 체크가 여러개 되어 있을 경우 int형식으로 못받아오고 배열형식으로 받아와햐해서
	String[] myno = request.getParameterValues("chk");

	//만일 내가 받아온 배열 myno의 값이 아무것도 없고, myno의 길이가 0 이라면.
	if (myno == null || myno.length == 0) {
	%>
	<script type="text/javascript">
	alert("하나 이상 체크해주세요");
	location.href="boardmain.jsp";
	</script>
	<%
		} else {
			//그렇지안고 배열 myno값이 있고 myno의 길이가 1이상이라는 의미이니까
			//dao를 사용하기 위해 객체생성해주고
			MyDao dao = new MyDao();
			//res에 값을 담아준다.
			int res = dao.multidelete(myno);
			
			if(res > 0){
	%>
			<script type="text/javascript">
			alert("선택삭제 성공");
			location.href="boardmain.jsp";
			</script>
	<%
			} else {
	%>
			<script type="text/javascript">
			alert("선택삭제 실패");
			location.href="boardmain.jsp";
			</script>
	<%
			}
		}
	%>
</body>
</html>