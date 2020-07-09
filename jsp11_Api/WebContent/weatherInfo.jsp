<!-- 컴파일 시 전부 사라진다. 남는건 검은글씨와 후에 출력한 문자들. -->
<!-- 여긴 html도 아니고 그냥 문자열 Servlet를 들렀다가 와서 -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>

<c:catch var="err">
	<!-- weatherURL이라는 변수 선언. value는 아래의 url + 마지막에 zone = code인 것
	code는 내가 위치에서 선택한 value값이 들어간다. -->
	<c:set var="weatherURL"
		value="http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=${code}" />
		<!-- weather이라는 변수에 위에서 선언한 weatherURL이라는 값을 import해준다. -->
		<!-- 위에서 변수설정해주고 value로 넣어준 값은 그저 문자열일뿐이고 import를 해줘야 진짜 url을 사용할 수 있게 해준다. -->
		<!-- 위의 경로를 요청해서 응답받은 xml파일이다. -->
	<c:import var="weather" url="${weatherURL}" />
	<!-- wrss라는 변수에 xml형식(응답받은 데이터 String)을 xml태그로 사용하게 변환해준 weather의 값을 담아준다. -->
	<!-- 문자열로 되어있는걸 우리가 원하는 객체(xml)를 파싱해준 것. -->
	<x:parse var="wrss" xml="${weather}" />
	<!-- 내가 wrss라고 선언한 url 아래에 rss 아래에 channel 아래에 pubDate를 출력해준다는 의미. -->
{"pubDate":"<x:out select="$wrss/rss/channel/pubDate" />",
"temp":"<x:out
		select="$wrss/rss/channel/item/description/body/data/temp" />",
"reh":"<x:out select="$wrss/rss/channel/item/description/body/data/reh" />",
"pop":"<x:out select="$wrss/rss/channel/item/description/body/data/pop" />",
"x":"<x:out select="$wrss/rss/channel/item/description/header/x" />",
"y":"<x:out select="$wrss/rss/channel/item/description/header/y" />",
"wfKor":"<x:out
		select="$wrss/rss/channel/item/description/body/data/wfKor" />"}
</c:catch>
<!-- 위의 err이라는 태그 안에 있는 값들이 null이 아니라면 err출력해준다.  -->
<c:if test="${err!=null}">
	${err}
</c:if>
