//로드 되자마자 아래의 getBike함수를 실행한다.
//window.onload = function(){}과 동일
$(function(){
	getBike();
});

//bike01.jsp의 값들을 전부 출력해주는 js파일.

function getBike(){
	//아래의 형태는
	/*
	 *$.ajax({
	 *	url : "json/bike.json",
	 *	success : function(data){
	 *	}
	 *});
	 *
	 *형식과 동일하다.
	 */
	//json폴더 밑에 bike.json파일을 function안의 파라미터 data에 담는다.
	$.getJSON("json/bike.json", function(data){
		//data는 현재 json/bike.json이 담겨있다.
		//function안에 key와 val이라는 의미는
		//data안에 담겨있는 json이
		//{"DESCRIPTION" : {k : v, k : v ...}, "DATA" : [{k:v, k:v..}, {k:v, k:v..}] }
		//형태이다. 자세히보면 key는 DESCRIPTION, DATA 두개이고 value도 key값에 맞게 2개이다.
		//그럼 총 2번 돈다는 의미이다.
		$.each(data, function(key, val){
			//만일 key값이 DESCRIPTION이라면
			if(key == "DESCRIPTION"){
				//table의 속성을 border : 1 속성을 추가하고
				$("table").attr("border", 1);
				//thead부분에 추가를 해줄것이다.
				$("thead").append(
				//tr태그 안에 th태그 안에 addr_gu의 value, content_id의 value..을 추가한다.
				//"DESCRIPTION" : {"NEW_ADDR":"대여소 주소","CONTENT_ID":"대여소번호","ADDR_GU":"구분","LONGITUDE":"경도","CRADLE_COUNT":"거치대수","LATITUDE":"위도","CONTENT_NM":"대여소명"}
				//에서 대여소주소, 대여소번호 등등을 의미한다.
				"<tr>" +
				"<th>" + val.ADDR_GU + "</th>" +
				"<th>" + val.CONTENT_ID + "</th>" +
				"<th>" + val.CONTENT_NM + "</th>" +
				"<th>" + val.NEW_ADDR + "</th>" +
				"<th>" + val.NEW_CRADLE_COUNT + "</th>" +
				"<th>" + val.NEW_LONGITUDE + "</th>" +
				"<th>" + val.NEW_LATITUDE + "</th>" +
				"</th>"
				);
			//만일 그렇지않다면(key값이 DATA라면)
			} else {
				//DATA는 현재
				//"DATA" : [{k:v}, {k:v}..] 형태의 배열이다.
				//list라는 변수에 DATA의 value를 담는다. 그렇게 되면 배열들 전체가 담기게 된다.(1163개)
				var list = val;
				//0부터 list의 마지막길이까지 for문을 돌아준다.
				for(var i = 0; i < list.length; i++){
					//str에는 list의 0번지부터 마지막 번지까지 한줄을 담으면서
					var str = list[i];
					//tbody에 tr태그 안에 td태그에  담은 한줄의 addr_gu의 value값을 넣고 반복한다.
					$("tbody").append(
					"<tr>" +
					"<td>" + str.addr_gu + "</td>"+
					"<td>" + str.content_id + "</td>" +
					"<td>" + str.content_nm + "</td>" +
					"<td>" + str.new_addr + "</td>" +
					"<td>" + str.cradle_count + "</td>" +
					"<td>" + str.longitude + "</td>" +
					"<td>" + str.latitude + "</td>" +
					//그리고 input태그로 숨겨서 이름을 bike로 그리고 value를
					// 슬래시로 나누어서 추가했다.
					 "<input type='hidden' name='bike' value='" +
					 str.addr_gu+"/"+
					 str.content_id+"/"+
					 str.content_nm+"/"+
					 str.new_addr+"/"+
					 str.cradle_count+"/"+
					 str.longitude+"/"+
					 str.latitude+"'/>"+
					 "</td>" +
					 "</tr>"
					);
				}
			}
		});
	});
}