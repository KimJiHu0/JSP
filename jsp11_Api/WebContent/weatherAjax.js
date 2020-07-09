$(function() {
	//weaView라는 버튼을 클릭했을 때 실행된다.
	$("#weaView").click(
			function() {
				//url은 weatherOpen이라는 어노테이션을 설정한 Servlet로 이동한다.
				var url = "weatherOpen";
				//code는 id가 address인 옵션이 선택된 것의 value값을 담는다.
				var code = $("#address option:selected").val();
				//ajax를 실행하는데
				$.ajax({
					//타입은 get방식이고
					type : "GET",
					//url은 weatherOpen + ? + id가 address인 애들 중 옵션이 선택된 애의 value값이다.
					url : url + "?code=" + code,
					//받는 타입은 text타입
					dataType : "text",
					//성공했을 시 아래의 함수 실행.
					//url인 servlet로 code값을 가지고 이동.
					success : function(data) {
						//weatherInfo.jsp에서 실행된 결과값을 data라는 것으로 받아오는데
						//temp에 공백을 다 잘라주고 담는다.
						var temp = $.trim(data);
						//그리고 그 담을 것들을 JSON형식으로 형변환 후 obj에 담기
						var obj = JSON.parse(temp);
						//JSON.parse() : 문자열을 json형태로 변환.
						//JSON.stringify() : json형태를 문자열로 형변환
						
						//weatherInfo.jsp에서 경로를 찾아서 담음 pubDate값을 weatherView.html에 id가 pubData인 곳에
						//value값으로 넣어준다.
						$("#pubDate").val(obj.pubDate);
						$("#temp").val(obj.temp);
						$("#x").val(obj.x);
						$("#y").val(obj.y);
						$("#reh").val(obj.reh);
						$("#pop").val(obj.pop);
						$("#wfKor").val(obj.wfKor);
							
						//weather_condition이라는 변수에 JOSN으로 형변환한 wfKor(날씨정보 ex ] 맑음 흐림 ..)
						var weather_condition = obj.wfKor;
						//날씨에 따라서 이미지의 속성으로 경로를 붙여주어서 보여준다.
						if (weather_condition == "맑음"){
							$("#weather_img").attr("src","/Jsp11_Weather/image/sun.png");
						}else if (weather_condition == "비"){
							$("#weather_img").attr("src","/Jsp11_Weather/image/rain.png");
						}else if (weather_condition == "눈"){
							$("#weather_img").attr("src","/Jsp11_Weather/image/snow.png");
						}else if (weather_condition == "흐림"){
							$("#weather_img").attr("src","/Jsp11_Weather/image/cloud.png");
						}else if (weather_condition == "구름 조금"){
							$("#weather_img").attr("src","/Jsp11_Weather/image/cloud_sun.png");
						}else{
							$("#weather_img").attr("src","/Jsp11_Weather/image/etc.png");
						}
					},
					error : function() {
						alert("정보를 불러오는데 실패하였습니다.");
					}
				});
			});
});
