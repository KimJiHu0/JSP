<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script type="text/javascript">
	function idCheck(){
		//doc이라는 변수에 name이 myid인 태그를 담았다.
		var doc = document.getElementsByName("myid")[0];
		
		//만일 name이 myid인 태그의 value값으로 아무것도 입력되어있지 않다면
		if(doc.value.trim() == "" || doc.value == null){
			alert("아이디를 입력해주세요.");
		//아이디가 제대로 입력되어있는 상태라면!
		} else{
			//controller.jsp로 command값과 id값을 보내주고 가로200 세로300의 창을 띄워준다.
			open("controller.jsp?command=idcheck&id="+doc.value,"","width=200 height=300");
		}
	}
</script>

</head>
<body>
	<h1>회원가입</h1>
	
	<form action="controller.jsp" method="get">
	<input type="hidden" name="command" value="registRes"/>
	<table border="1">
		<tr>
			<th>ID </th>
			<td><input type="text" name="myid" required="required" title="n"/></td>
			<!-- 중복체크를 클릭하면 idCheck라는 함수가 실행된다. -->
			<td><input type="button" value="중복체크" onclick="idCheck();"/></td>
		</tr>
		<tr>
			<th> PassWord </th>
			<td colspan="2"><input type="text" name="mypw"/></td>
		</tr>
		<tr>
			<th>Name </th>
			<td colspan="2"><input type="text" name="myname"/></td>
		</tr>
		<tr>
			<th>Address </th>
			<td colspan="2"><input type="text" name="myaddr"/></td>
		</tr>
		<tr>
			<th>PhoneNumber </th>
			<td colspan="2"><input type="text" name="myphone"/></td>
		</tr>
		<tr>
			<th>E-mail </th>
			<td colspan="2"><input type="text" name="myemail"/></td>
		</tr>
		<tr>
			<td colspan="3" align="right">
				<input type="submit" value="으아아아악"/>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>