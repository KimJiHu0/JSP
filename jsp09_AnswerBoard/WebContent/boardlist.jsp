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
</head>
<body>

   <h1>글 목록</h1>
   <table border=1>
      <col width=50/>
      <col width=200/>
      <col width=100/>
      <col width=100/>
      <tr>
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
                        <td colspan=4 align="center"><c:out value="-----삭제된 글 입니다-----"></c:out></td>
                     </tr>
                  </c:when>
                  <c:otherwise>
                     <tr>
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
      	<td colspan="4" align="right"><input type="button" value="글작성" onclick="location.href='controller.do?command=insert'"/></td>
      </tr>
   </table>
</body>
</html>