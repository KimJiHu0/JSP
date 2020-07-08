function getParameterValues(){
	//student.html에서 전달해준 값들 받아오기
	//encodeURIComponent : 값을 전달할 때 ?name=name&kor=kor 이런 식으로 전달하게 된다.
	//이 때 &의 역할은 하나의 파라미터가 끝나고 다음 파라미터가 온다는 의미인데
	//이를 쓰게된다면 시스템은 name값을 제대로 인식할 수 없다.
	//그래서 아래와 같은 기능을 통해서 &을 %26으로 이스케이핑해준다. 그래서 제대로 인식할 수 있게 해준다.
	
	//name이라는 변수에는 name= 과 id가 name인 태그의 value값을 더해서 담아준다. 아래들도 동일하다.
	var name = "name=" + encodeURIComponent(document.getElementById("name").value);
	var kor = "kor=" + encodeURIComponent(document.getElementById("kor").value);
	var eng = "eng=" + encodeURIComponent(document.getElementById("eng").value);
	var math = "math=" + encodeURIComponent(document.getElementById("math").value);
	
	//?name=name&kor=kor ... 값으로 만들어준다.
	var queryString = "?"+name+"&"+kor+"&"+eng+"&"+math;
	
	//그리고 그것을 리턴한다.
	return queryString;
}

//성적확인 버튼을 클릭했을 때 실행되는 함수이다.
function load(){
	//보내줄 url을 변수로 만들고 score.do 뒤에 같이 보낼 값을(위에 기능 구현)넣어준다.
	var url = "score.do"+getParameterValues();
	//만일 var가 생략된다면 변수가 호이스팅이 된다. 전역변수 제일 위에 모여버린다.
	
	//일명 XHR이라고도 부르는데 이는 서버와 통신할 떄 필요한 객체이다.(JS객체)
	//XHR : JAVASCRIPT에 내장되어있는 Object개게이다. http라는 프로토컬을 통해 데이터를 보내고 받고를 지원
	httpRequest = new XMLHttpRequest();
	
	//on이 붙은 이유는 이벤트이기 때문이다.
	//바뀔때마다(readystatechange) 처리할 함수를 실행해준다.
	//0 : uninitialized : 실행(로드)되지 않음.
	//1 : loading : 로드중(실행중)
	//2 : loaded : 로드됨(실행완료)
	//3 : interactive : 통신되는중
	//4 : complete : 통신 완료
	//callback : 내가 요청해줄게 그럼 해당 함수는 되돌려준다는 의미.
	//요청해서 응답하고 요청해서 응답하고 형태를 띄운다.
	httpRequest.onreadystatechange = callback;
	
	//true : 비동기 / false : 동기
	//새로운 창을 띄울거다. get방식으로 보낼거고 url으로 보낼것이고 비동기로 보낼 것이다!
	httpRequest.open("GET", url, true);
	
	//.send() : get방식 / .send(String) : post방식
	httpRequest.send();	
	
	//위에서 httpRequest.onreadystatechange = callback;를 작성했다.
	//요청하면 응답한다구 했다. 요청이 들어왔기 때문에 응답을 할 함수를 만들어준다.
	function callback(){
		//바뀔때마다 처리할 함수를 실행해주는데 0,1,2,3,4,를 순서대로 출력해줄것이다.
		alert("readyState : " + httpRequest.readyState);
		
		//만일 4라면 (통신이 완료되었다면)
		if(httpRequest.readyState == 4){
			
			//status를 alert해준다.
			 //-status
			 //200 : 정상(성공)제대로 응답됐다는 의미.
			 //400 : bad request 잘못 요청했다. get방식인데 post방식으로 요청한다는 것
			 //401 : unauthorized : 권한, 인증
			 //403 : forbidden :
			 //404 : not found
			 //500 : internal server error
			alert("status : " + httpRequest.status);
			
			//만일 정상적으로 작동했다면
			if(httpRequest.status == 200){
				//요청한 곳에서 가져온 text를 json형태로 변환해준다.
				var obj = JSON.parse(httpRequest.responseText);
				
				document.getElementById("result").innerHTML = 
						decodeURIComponent(obj.name) + " 님의 총점은 " + obj.sum
						+ "이고, 평균은 "+obj.avg + "입니다."
			} else {
				alert("데이터를 계산할 수 없습니다.");
			}
		}
	}
}