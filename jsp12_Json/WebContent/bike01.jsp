<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- JQuery와 js폴더 밑에 bike01.js 외부작성한 js파일을 쓰겠다는 뜻. -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/bike01.js"></script>
</head>
<body>
	<h1>드릉이!!</h1>
	
	<form>
		<input type="submit" value="DB저장"/>
		<input type="hidden" name="command" value="first_db"/>
		
		<table>
			<!-- thead : 가장 상단 한줄을 의미, tbody : 아래 내용들을 의미. -->
			<thead></thead>
			<tbody></tbody>
		</table>
	</form>
</body>
</html>