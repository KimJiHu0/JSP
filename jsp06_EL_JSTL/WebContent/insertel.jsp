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


	<!-- 이곳에서는 el을 사용해볼 것이다. myscore에서 score를 작성한 것을 가져와 사용할 것이다. -->
	<!-- controller에서 값을 담아서 보낸것을 jsp로 사용하려면 꺽새 %를 사용해서 보낸 값을 getAttribute로
	받아오고 사용할 수 있었지만 el은 값을 받아오지 않고도 score class의 name을 사용할 수 있다.
	사실 score.name은 score.getName()과 같은 의미인데 변수를 불러오는게 아니라 메소드를 호출한다는 의미다. 
	score는 controller에서 setAttribute로 지정해준 이름을 가져다가 쓰는 것이다.-->
	<table border = "1">
		<tr>
			<th colspan="2">${score.name}님의 점수</th>
		</tr>
		<tr>
			<th>국어</th>
			<td>${score.kor}</td>
		</tr>
		<tr>
			<th>영어</th>
			<td>${score.eng}</td>
		</tr>
		<tr>
			<th>수학</th>
			<td>${score.math}</td>
		</tr>
		<tr>
			<th>총점</th>
			<td>${score.sum}</td>
		</tr>
		<tr>
			<th>평균</th>
			<td>${score.avg}</td>
		</tr>
		<tr>
			<th>등급</th>
			<td>${score.grade}</td>
		</tr>
	</table>

</body>
</html>