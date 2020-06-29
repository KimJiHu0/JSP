<%@page import="com.biz.MVCbiz"%>
<%@page import="com.dto.MVCdto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
	mvc1패턴은 model과 controller이 섞여있었지만 mvc2패턴에는 확실하게 구분이 되어 
	controller를 무조건 지나쳐 가야한다.
	view에서 다른 view로 이동하고 시을 때 제어해주는게 controller.
	db도 controller가 db에 요청해서 응답받는것도 controller.
	model과 controller를 완벽하게 분리해준게 mvc2패턴.
	db든 view든 어딜 가든 controller를 거친다.
	-->
	
	<%
	//scriptlet
	//index에서 전달해주려는 command값을 받아온다.
	//요고슨 전역변수!
	String command = request.getParameter("command");
	
	//model을 사용하기 위해 biz객체를 생성
	//biz도 전역변수로 생성.
	MVCbiz biz = new MVCbiz();
	
	//만일 커맨드 값에 list라면
	if(command.equals("list")){
		//biz에 있는 selectList를 실행시켜 나온 결과값을 list에 담아준다.
		List<MVCdto> list = biz.selectList();
		
		//biz를 통해 가져온 객체를 내가 원하는 페이지로 이 객체를 넘겨주기 위해서
		//request에 속성 추가한다.
		request.setAttribute("list", list);
		
		pageContext.forward("boardlist.jsp");
	} else if(command.equals("detail")){
		//1. 전달된 값 받기
		//boardlist.jsp에서 command와 함께 보낸 myno값을 받아온다.
		int myno = Integer.parseInt(request.getParameter("myno"));
		
		//2.db에서 값 가져오기.
		//biz에 있는 selectOne을 실행한 결과값을 dto에 담는다.
		MVCdto dto = biz.selectOne(myno);
		
		//3.전달할 값 저장
		//request에 객체를 저장하고 dto라고 이름을 지어준것.
		//그리고 boarddetail에서 selectOne한 값을 가져올 때 dto를 사용해서 가져온다.
		request.setAttribute("dto", dto);
		
		//4.화면 전환
		pageContext.forward("boarddetail.jsp");
	} else if(command.equals("update")){
		//1.전달된 값 받기.
		int myno = Integer.parseInt(request.getParameter("myno"));
		String mytitle = request.getParameter("mytitle");
		String mycontent = request.getParameter("mycontent");
		
		//수정된 갯수를 리턴해야하기 때문에  int를 사용해주는데 dto에서 이미 파라미터 3개받는 생성자를 썼기 때문에 사용할 수 있다.
		int res = biz.update(new MVCdto(myno, mytitle, mycontent));
		System.out.println(myno + mytitle + mycontent+ "여기에여!!!!");
		if(res > 0) {
	%>
	<script type="text/javascript">
	alert("수정 성공");
	location.href="boardcontroller.jsp?command=detail&myno=<%=myno%>";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
	alert("수정실패");
	location.href="boardcontroller.jsp?command=detail&myno=<%=myno%>";
	</script>
	<%
		}
	} else if(command.equals("delete")){
		//boarddelete.jsp에서 보낸 command값인 delete가 있다면
		//boarddelete.jsp에서 보낸 myno값을 받아오고
		int myno = Integer.parseInt(request.getParameter("myno"));
		//return줄 값이 int형이기 때문에 int사용하고 biz에서 계산연산처리한 delete를 담아준다.
		int res = biz.delete(myno);
		System.out.println(myno+"여기에여!!!!");
		
		//삭제에 성공했다면.
		if(res > 0){
		%>
		<script type="text/javascript">
		alert("삭제성공");
		//이 페이지로 이동
		location.href="boardcontroller.jsp?command=list";
		</script>
		<%
	} else {
		%>
		<script type="text/javascript">
		alert("삭제실패");
		//실패했다면 boarddetail.jsp로 가는데 command는  detail이고 myno값을 가지고 간다.
		location.href="boarddetail.jsp?command=detail&myno=<%=myno%>";
		console.log(myno + mytitle, mycontent + "씨발련아!");
		</script>
		<%
		}
	} else if(command.equals("insert")){
		//boardlist.jsp에서 넘겨준 command값 insert를 확인하여 만약 insert가 있다면
		//명령문을 실행해주는데 boardinsert.jsp로 이동할 때에는 아무 값도 가져가지 않아도 되기 때문에
		//페이지를 이동해주는 명령문을 작성한다.
		pageContext.forward("boardinsert.jsp");
		
	} else if(command.equals("insertRes")){
		//boardinsert.jsp에서 넘겨진 command값이 insertRes라면
		//boardinsert.jsp에서 넘겨준 값들을 name을 통해서 받아온다.
		String myname = request.getParameter("myname");
		String mytitle = request.getParameter("mytitle");
		String mycontent = request.getParameter("mycontent");
		
		//그리고 insert도 작성 성공한 row의 갯수를 리턴하기 때문에 int형을 사용하였고
		//biz에서 insert를 실행한 후에 파라미터 3개받는 생성자를 통해서 값을 처리하고 res에 담을 수 있게 했다.
		int res = biz.insert(new MVCdto(myname, mytitle, mycontent));
		
		//작성에 성공했다면
		if(res > 0){
		%>
		<script type="text/javascript">
		alert("작성 성공");
		//boardcontroller.jsp로 다시 보내주는데 command값이 list이기 때문에 boardlist.jsp화면이 뜰거고
		location.href="boardcontroller.jsp?command=list";
		</script>
		<%
		} else {
		%>
		<script type="text/javascript">
		alert("작성 실패");
		//작성 실패하면 command값이 insert이기 때문에 boardinsert.jsp로 이동하게 될 것이다.
		location.href="boardcontroller.jsp?command=insert";
		</script>
		<%
		}
	}
		%>
</body>
</html>