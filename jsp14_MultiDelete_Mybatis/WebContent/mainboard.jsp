<%@page import="com.my.model.dto.MyDto"%>
<%@page import="java.util.List"%>
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
<script type="text/javascript"
	src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	
	
	
	function allChks(bool) {
		var chks = document.getElementsByName("chk");
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked = bool;
		}
	}
	$(function() {
		//mainboardlist에서 가져오는 새로운 로우들은 java이기 때문에
		//js가 document를 탐색하기 전에 이미 td 다 만들어져 있는 상태
		//서버에서 html로 이미 변환이 다 된 후 클라이언트에 응답된 document를 js가 탐색하게 된다.
		//그래서 click를 쓰던지 on을 쓰던지 둘 다 똑같은 결과를 도출해낸다.
		$("input[name=chk]").click(function() {
		
			if($("input[name=chk]").length == $("input[name=chk]:checked").length){
				//prop : checked속성이 있다면 true로 바꾸어줘라,
				//앞에 선택한 input타입 중 name이 all인 태그의 속성값을 가져오거나 추가한다.
				$("input[name=all]").prop("checked", true);
			} else {
				$("input[name=all]").prop("checked", false);
			}
		});
		
		$("#muldelform").submit(function() {
			if ($("#muldelform input:checked").length == 0) {
				alert("하나 이상 체크하셔야합니다.");
				return false;
			}
		});
	});
</script>

</head>
<body>
	<%
		MyDao dao = new MyDao();
	List<MyDto> list = dao.selectList();
	%>
	<form action="muldel.jsp" method="post" id="muldelform">
		<table border="1">
			<col width="30" />
			<col width="50" />
			<col width="100" />
			<col width="300" />
			<col width="100" />
			<tr>
				<td><input type="checkbox" name="all"
					onclick="allChks(this.checked)" /></td>
				<th>번 호</th>
				<th>작성자</th>
				<th>제 목</th>
				<th>날 짜</th>
			</tr>
			<%
				if (list.size() == 0) {
			%>
			<tr>
				<td colspan="5" height="500" align="center">글이 존재하지 않습니다.</td>
			</tr>
			<%
				} else {
				for (MyDto dto : list) {
			%>
			<tr>
				<td><input type="checkbox" name="chk"
					value="<%=dto.getMyno()%>" /></td>
				<td align="center"><%=dto.getMyno()%></td>
				<td align="center"><%=dto.getMyname()%></td>
				<td><a href="myselect.jsp?myno=<%=dto.getMyno()%>"><%=dto.getMytitle()%></a></td>
				<td align="center"><%=dto.getMydate()%></td>
			</tr>
			<%
				}
			}
			%>

			<tr>
				<td colspan="5" align="right"><input type="button" value="글 작성"
					onclick="location.href='myinsert.jsp'" /> <input type="submit"
					value="선택 삭제하기" /></td>
			</tr>
		</table>
	</form>



</body>
</html>