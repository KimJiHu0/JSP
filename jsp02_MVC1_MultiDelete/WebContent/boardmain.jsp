<%@page import="com.dao.MyDao"%>
<%@page import="com.dto.MyDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글목록</title>

<script type="text/javascript">

function allChks(bool){
	//태그의 name이 chk인 애들을 chks에 담아주었다.
	var chks = document.getElementsByName("chk");
	//태그들이 담긴 chks의 길이만큼 for문을 도는데
	for(var i = 0; chks.length; i++){
		//chks의 i번지의 checked 되어있다면 bool은 true가 되어
		// 이 부분 다시....설명..
		chks[i].checked = bool;
	}
}
//만일 id가  muldelform인 애가 submit이벤트가 발생 했다면 함수실행.
$("#muldelform").submit(function(){
	//만일 id가 muldelform 하위 태그중 input태그의 checked속성이 true인 애의 길이가 0 이라면
	if($("#muldelform input:checked").length==0){
		//하나이상 체크해달라는 alert창을 띄운다.
		alert("하나 이상 체크하셔야합니다.");
		//이벤트 전파 막기 false
		return false;
	}
});

</script>

</head>
<body>
<%
	//dao에 있는 메소드를 사용하기 위해서 dao객체 생성
	MyDao dao = new MyDao();
	//dao에 있는 selectList 메소드를 실행 한 후에 나온 결과값을 List배열에 MyDto타입인 list변수에 값을 넣어준다.
	List<MyDto> list = dao.selectList();
%>
<form action = "boardmuldel.jsp" method="post" id="muldelform">
	<table border = "1">
	<col width = "30"/>
	<col width = "100"/>
	<col width = "100"/>
	<col width = "300"/>
	<col width = "100"/>
		<tr>
			<!-- 
			name에 all을 주었다. 이 체크박스의 의미는 전체선택 체크박스를 의미한다. 만일 체크박스를 체크했다면
			allChks라는 함수가 실행 될 것이고 this.checked라는 의미는 나 자신이 체크되어있을 때를 의미한다.
			 -->
			<td><input type="checkbox" name="all" onclick="allChks(this.checked);"/></td>
			<th>No</th>
			<th>Name</th>
			<th>Title</th>
			<th>Date</th>
		</tr>
		
		<%
		//현재 list에 담겨있는 size만큼 for문을 돈다.
		for(int i = 0; i < list.size(); i++){
		%>
		<tr>
		<!-- 
		list의 있는 i번지에 체크박스를 만들어준다.
		list에 있는 i번지의 myno값을 가져오고
		list에 있는 i번지의 myname값을 가져오고
		list에 있는 i번지의 mytitle값을 가져오고
		list에 있는 i번지의 mydate값을 가져온다.
		 -->
		 	<td><input type="checkbox" name="chk" value="<%=list.get(i).getMyno()%>"/></td>
			<td><%=list.get(i).getMyno()%></td>
			<td><%=list.get(i).getMyname()%></td>
			<!-- 가져온 값 Title을 누르게 되면 a태그가 발생하는데 boardselectone.jsp가면서 myno라는 값을 가지고 간다. -->
			<td><a href="boardselectone.jsp?myno=<%=list.get(i).getMyno()%>"><%=list.get(i).getMytitle()%></a></td>
			<td><%=list.get(i).getMydate()%></td>
		</tr>
		<%
		}
		%>
		<tr>
			<td colspan = "5" align = "right">
			<!-- 글작성 버튼을 클릭하면 boardinsert.jsp로 넘어간다. -->
				<input type="button" value="글 작성" onclick="location.href='boardinsert.jsp'"/>
				<input type="submit" value="선택 삭제"/>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>