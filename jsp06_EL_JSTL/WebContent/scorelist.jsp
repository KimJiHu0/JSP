<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!-- 아래의 애는 JSTL을 사용하기 위해서 무조건 작성해야하는 구문이다. -->
<!-- 가장 기본적인 core이다. 이는 태그들의 모음집이기도 하고 java에서 사용하는 구문들도 태그로 -->
<!-- 사용할 수 있다. <c 를 먼저 시작한다 . -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table border="1">
		<tr>
			<th>이름</th>
			<th>국어</th>
			<th>영어</th>
			<th>수학</th>
			<th>총점</th>
			<th>평균</th>
			<th>등급</th>
		</tr>
		<!-- items : Connection객체[List, ArrayList] -->
		<!-- value : 사용할 변수명 -->
		<!-- for(score score : list) 의미. -->
		<!-- score라는 변수에 listscore가 가지고있는 값 0번지부터 마지막번지까지 하나하나 꺼내서 담는다. -->
		<c:forEach items="${listscore}" var="score">
			<tr>
				<!-- out은 출력문을 의미한다. scorelist의 0번지부터 마지막번지까지 세로로 출력해준다. -->
				<td>
					<!-- 만일 이름이 eq '이름10' 이라면 -->
					<c:if test="${score.name eq '이름10'}">
						<!-- 홍길동으로 바꿔줘라. -->
						<c:out value="홍길동"></c:out>
					</c:if>
					<!-- 
					choose는 switch같은 의미를 지녔다.
					when은 조건을 의미한다 ~라면의 의미를 가진다.
					otherwise는 when의 조건이 일치하지 않을 경우를 의미한다.
					위의 3개는 하나의 세트라고 볼 수 있다.
					 -->
					<c:choose>
						<c:when test="${score.name eq '이름20'}">
							<c:out value="이순신"></c:out>
						</c:when>
						<c:when test="${score.name eq '이름30'}">
							<c:out value="신사임당"></c:out>
						</c:when>
						<c:otherwise>
							<c:out value="권율"></c:out>
						</c:otherwise>
					</c:choose>
				</td>
				
				<td>${score.kor}</td>
				
				<td>
					<c:choose>
						<c:when test="${score.eng ge 80}">
							<c:out value="멍멍"></c:out>
						</c:when>
						<c:when test="${score.eng le 70}">
							<c:out value="냐용"></c:out>
						</c:when>
					</c:choose>
				</td>
				
				<td>${score.math}</td>
				
				<td>${score.sum}</td>
				
				<td>${score.avg}</td>
				
				<td>
					<!-- 말 그대로 if문을 의미한다. grade가 eq(==) B라면 ||은 이어서 쓸 수 있는 의미다 -->
					<!-- OUT문에서 value는 내가 출력할 값을 의미한다고 볼 수 있다. -->
					<c:if test="${score.grade eq 'B' || score.grade eq 'C'}">
						<c:out value="pass"></c:out>
					</c:if>
					<c:if test="${score.grade eq 'D' || score.grade eq 'F'}">
						<c:out value="fail"></c:out>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>