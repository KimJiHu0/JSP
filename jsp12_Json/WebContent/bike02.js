$(function() {
	parseBike();
});
//bike02.jsp가 로드되면 바로 실행되는 외부 js
function parseBike() {
	//json/bike.json을 function안에 파라미터로 data라는 이름으로 대입.
	$.getJSON("json/bike.json", function(data) {
		// 비동기로 실행
		$.ajax({
			// url은 servlet에 bike.do
			url : "bike.do",
			// 방식은 post방식으로 전송
			method : "post",
			//data는 내가 보내는 타입을 의미한다.
			//obj라는 변수에 JSON타입을 stringify를 이용해서
			//JSON타입을 JSON형태의 문자열로 바꿔준다.
			//그리고 command는 second_db값이다.
			data : {
				"obj" : JSON.stringify(data),
				"command" : "second_db"
			},

			// url접속에 성공한다면
			success : function(msg) {
				if (msg > 0) {
					alert(msg);
					$.each(data, function(key, val) {
						if (key == "DESCRIPTION") {
							$("table").attr("border", 1);
							var $tr = $("<tr>");
							// 오른쪽에 있는 val을 i에 넣어주는걸 반복적으로 넣어주는데 val을 다
							// 가져올때까지.(속성까지두)
							// i는 val의 key값을들 가져온다.
							for ( var i in val) {
								// val의 key를 가져와서 th에 넣었음!!!!!그리거 tr에 넣었음!!!
								$tr.append($("<th>").html(val[i]));
							}
							$("thead").append($tr);
						} else {
							for (var i = 0; i < val.length; i++) {
								var $tr = $("<tr>");
								for ( var j in val[i]) {
									// val[i]는 배열 하나하나 1163개.
									// val의 i번지에는 json이 들어오는데 그 안에 하나의 값의 key의
									// value값을 가져운다는 의미.
									$tr.append($("<td>").html(val[i][j]));
								}
								$("tbody").append($tr);
							}
						}
					});
				} else {
					alert("db 저장 실패");
				}
			},
			error : function() {
				alert("통신 실패");
			}
		});
	});
}