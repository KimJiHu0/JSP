<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">


	function allChk(bool){
		//chk라는 name을 가진 체크박스를 chks에 담아준다.
		var chks = document.getElementsByName("chk");
		//내가 버튼을 클릭해서 allChk라는 함수가 실행되었을 때 bool은 true가 되고 체크를 해제했을 때는 bool이 false가 된다.
		//그럼 내가 all이라는 name을 가진 체크박스를 클릭했을 때
		for(var i = 0; i < chks.length; i++){
			//for문을 돌려서 chk라는 name을 담아준 chks를 모두 true로 바꿔준다.
			chks[i].checked = bool;
		}
	}
	
	$(function(){

		//form태그가 submit이벤트가 발생했을 때
		$("#multidelform").submit(function(){
			//만일 multidelform의 하위태그 중 input태그의 checked속성인 애의 길이가 0이라면(체크되어있는애가 없다면)
			if($("#multidelform input:checked").length == 0){
				alert("하나 이상 체크하셔야합니다.");
				
				return false;
			}
		});
		$("input[name=chk]").click(function(){
	         if($("input[name=chk]").length != $("input[name=chk]:checked").length){
	            $("input[name=all]").prop("checked",false);
	         } else {
	            $("input[name=all]").prop("checked",true);
	         }
	      });
	});
	
	
</script>
</head>
<body>

   <h1>글 목록</h1>
   <form action = "controller.do" method="get" id="multidelform">
   <input type="hidden" name="command" value="multidel"/>
   <table border=1>
   	  <col width=50/>
      <col width=50/>
      <col width=300/>
      <col width=100/>
      <col width=100/>
      <tr>
      	<td><input type="checkbox" name="all" onclick="allChk(this.checked)"/></td>
         <th>번  호</th>
         <th>제  목</th>
         <th>작성자</th>
         <th>작성일</th>
      </tr>
      <c:choose>
         <c:when test="${empty list }">
            <tr>
               <td colspan=4>-----작성된 글이 존재하지 않습니다-----</td>
            </tr>
         </c:when>
         <c:otherwise>
            <c:forEach items="${list }" var="dto">
               <c:choose>
                  <c:when test="${dto.delflag eq 'Y' }">
                     <tr>
                        <td colspan=5 align="center"><c:out value="-----삭제된 글 입니다-----"></c:out></td>
                     </tr>
                  </c:when>
                  <c:otherwise>
                     <tr>
                     	<td><input type="checkbox" name="chk" value="${dto.boardno}"/></td>
                        <td>${dto.boardno }</td>
                        <td>
                           <c:forEach begin="1" end="${dto.titletab }">
                              &nbsp;
                           </c:forEach>
                           <a href="controller.do?command=boarddetail&boardno=${dto.boardno}">${dto.title }</a>
                        </td>
                        <td>${dto.writer }</td>
                        <td>${dto.regdate }</td>
                     </tr>
                  </c:otherwise>
               </c:choose>
            </c:forEach>
         </c:otherwise>
      </c:choose>
      <tr>
      	<td colspan="5" align="right">
      		<input type="button" value="글작성" onclick="location.href='controller.do?command=insert'"/>
      		<input type="submit" value="선택 글 삭제"/>	
      	</td>
      </tr>
   </table>
   </form>
</body>
</html>