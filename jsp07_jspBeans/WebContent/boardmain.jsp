<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
    <!-- 이제 jstl을 사용할 수 있다. WEB-INF밑에 파일 3개와 아래와 같이 구문을 작성했기 때문이다. -->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 목록</title>
</head>
<body>
<!-- 
Class명인 MyDto 에서 dto라는 아이디를 쓰겠다는 의미로 생각해도 된다.
그럼 MyDto dto 가 될 것인데 jsp:useBean은 객체를 사용하겠다는 의미이다.
그럼 MyDto dto = 에서 객체생성인 new MyDto(); 가 붙을 것이다.
그래서 MyDto dto = new MyDto(); 가 되어 객체를 사용할 수 있을 것이고 scope의 범위가 request인 것은
controller(servlet)에서 request객체에 담아서 보냈기 때문에 request로 받았다고 볼 수 있다.
 -->
<jsp:useBean id="dto" class="com.dto.MyDto" scope="request"></jsp:useBean>
	<h1>글 목록</h1>
	
	<table border="1">
	<col width="100"/>
	<col width="100"/>
	<col width="300"/>
	<col width="100"/>
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>날짜</th>
		</tr>
		<!-- 
		for(MyDto dto : list) 
		볌수의 이름을 dto로 했다. items : list에 담겨있는 것들을 dto에 하나씩 담아준다
		-->
		<c:forEach items="${list}" var="dto">
			<tr>
				<td>
					<!-- 상단에 jspuseBean을 사용했기 때문에 getProperty를 이용해서 값을 사용할 수 있다. -->
					<jsp:getProperty property="seq" name="dto"/>
				</td>
				<td>
					<jsp:getProperty property="writer" name="dto"/>
				</td>
				<td>
					<!-- 하나의 제목을 클릭하게되면 controller.do를 찾아서 Servlet로 간다. 그리고 command값을 detail을 가지고 간다.
					그리고 해당 글의 primary key인 seq를 가지고간다. -->
					<a href="controller.do?command=detail&seq=${dto.seq}"><jsp:getProperty property="title" name="dto"/></a>
				</td>
				<td>
					<jsp:getProperty property="regdate" name="dto"/>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="4" align="right">
				<!-- insert를 누르게 되면 controller.do를 찾은 후 servlet이랑 연결되어 있어서 controller로 간다. -->
				<input type="button" value="글작성" onclick="location.href='controller.do?command=insert'"/>
			</td>
		</tr>
		
	</table>
</body>
</html>