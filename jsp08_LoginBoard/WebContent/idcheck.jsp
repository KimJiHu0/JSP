<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	onload=function(){
		//opner은 부모를 의미한다. 부모의 아이디.0번지.(userregist.jsp)
		var id = opener.document.getElementsByName("myid")[0].value;
		//회원가입할 떄 id를 입력하고 중복체크를 눌렀을 것이다. 그럼 창이 띄어졌을 떄 그 입력한 값이 그대로
		//새로운 창에도 떠야하기 때문에 창이 뜨면 그 첫번째에 name이 id인 text에 부모의 myid에 입력한 값이
		//그래도 가져와지게 해준다.
		document.getElementsByName("id")[0].value = id;
	}
	function confirmId(bool){
		if(bool == "true"){
			//true라면 부모의 myid title를 y로 변경
			opener.document.getElementsByName("myid")[0].title = 'y';
			//title을 y로 바꾸고 다음 pw에 초점이 가도록 만들어준다. 커서 자동이동.
			opener.document.getElementsByName("mypw")[0].focus();
		} else{
			//그렇지 않으면 myid에 포커스.
			opener.document.getElementsByName("myid")[0].focus();
		}
		self.close();
	}
</script>
</head>
<body>
	<%
		String idnotused = request.getParameter("idnotused");
	%>
	
	<table border="1">
		<tr>
			<td>
				<input type="text" name="id"/>
			</td>
		</tr>
		<tr>
			<!-- 삼항연산자 사용  idnotused의 값이 true면 아이디 생성가능, false면 중복된 아이디 존재-->
			<td><%=idnotused.equals("true")?"아이디 생성가능" : "중복된 아이디 존재" %>
		</tr>
		<tr>
			<td>
			<!-- onclick이벤트 안에 ''를 사용한 이유 -->
		<input type="button" value="확인" onclick="confirmId('<%=idnotused %>');"/>
			</td>
		</tr>
	</table>
</body>
</html>