<%@page import="com.my.model.dao.MyDao"%>
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
		String[] myno = request.getParameterValues("chk");

	if (myno == null || myno.length == 0) {
	%>
	<script type="text/javascript">
		alert("하나 이상 체크해주시오~");
		location.href = "mainboard.jsp";
	</script>
	<%
		} else {
		MyDao dao = new MyDao();
		int res = dao.multiDelete(myno);

		if (res > 0) {
	%>
	<script type="text/javascript">
		alert("삭제에 성공했습니다!");
		location.href = "mainboard.jsp";
	</script>
	<%
		} else {
	%>
		<script type="text/javascript">
			alert("삭제에 실패했습니다!");
			location.href="mainboard.jsp";
		</script>
	<%
		}
	}
	%>

</body>
</html>