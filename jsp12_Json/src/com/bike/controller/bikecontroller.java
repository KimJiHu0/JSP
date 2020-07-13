package com.bike.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bike.dao.BikeDao;
import com.bike.dto.BikeDto;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


@WebServlet("/BikeController")
public class bikecontroller extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public bikecontroller() {
    	
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//인코딩해주기
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		System.out.println("<"+command+">");
		BikeDao dao = new BikeDao();
		
		//index.jsp에서 first를 클릭하면 command값으로 first가 넘어와서
		if(command.equals("first")) {
			//bike01.jsp로 이동시켜준다.
			response.sendRedirect("bike01.jsp");
		}
		
		//DB저장 버튼을 클릭하면 first_db라는 command값이 넘어온다.
		else if(command.equals("first_db")) {
			
			if(dao.delete()) {
				System.out.println("삭제성공");
			}
			
			//bike01.jsp에서 한줄한줄에 name이라고 지정해준 값들을 받아왔다.
			//현재 이 값은 ㅇㅇㅇ/ㅇㅇㅇ/ㅇㅇㅇ/ㅇㅇㅇ 식으로 받아와져있다.
			//(input태그의 value값) = name은 bike
			//값이 여러개이기 때문에 배열로 받아준다.
			//{"key":"val"}
			//{"key":"val"} 얘네들의 name이 bike
			//{"key":"val"} 식 값의 values를 저장 
			String [] bikeList = request.getParameterValues("bike");
			//hidden으로 숨겨진 강남구/ㅇㅇㅇ/ㅇㅇㅇ/ㅇㅇㅇ 식의 값을 문자열로 짤라서 dto에 담아서 db에 저장할거다.
			
			//배열을 ㅅ ㅓㄴ언해주고
			List<BikeDto> bikes = new ArrayList<>();
			
			//for문으로 bikeList의 길이만큼 돌아주는데(1163개)
			for(int i = 0; i < bikeList.length; i++) {
				// bikeList의 0번지부터 마지막번지까지 슬래쉬로 짤라서 tmp에 담아준다.
				//0번지에 값들을 /로 짤라서 tmp에 담고, 1번지의 가밧들을 /로 짤라서 tmp에 담고,, 반복
				String[] tmp = bikeList[i].split("/");
				//그것들을 dto 하나에 담아주고
				BikeDto dto = new BikeDto(
						//짤라서 담은 값들은 모두 String 값이기 때문에 
						//원래의 타입으로 맞게 형변환.
							tmp[0],
							Integer.parseInt(tmp[1]),
							tmp[2],
							tmp[3],
							Integer.parseInt(tmp[4]),
							Double.parseDouble(tmp[5]),
							Double.parseDouble(tmp[6])
						);
				//bikes라는 List에 dto한줄을 담아준다.(이를 1163번 반복한다.)
				bikes.add(dto);
			}
			//모두 성공한 dao에서 실행한 res를 res라는 변수에 담아준다.
			int res = dao.insert(bikes);
			//성공하면
			if(res > 0) {
				System.out.println("insert 성공");
			//실패하면
			} else {
				System.out.println("insert 실패");
			}
			response.sendRedirect("bike01.jsp");
		} else if(command.equals("second")) {
			response.sendRedirect("bike02.jsp");
		} else if(command.equals("second_db")) {
			/*
			 * JsonObject : Key와 value의 한쌍이 들어가있다. Json객체. [key는 문자열, v는 JsonElement.(뭐가올지 몰라서 json요소라고 칭함.)]
			 * JsonElement : Json요소 => JsonObject, JsonArray, JsonPrimitive, JsonNull일수도 있다. 
			 * Json의 요소가 여러개일 수 있기 때문에 통틀어서 칭함. Json값을 가져온다.
			 */
			
			//문자열로 넘어온 obj bike02.js에서 원래 json형태의 값을 String으로 변경해준것이다.
			String objString = request.getParameter("obj");
			//System.out.println(objString);
			
			//json형태로 값을 바꿔준다.
			//parseString안의 String문자열을 Json형태로 변경
			//objString이 String타입인거를 parseString이 읽어주고 json타입으로
			JsonElement element = JsonParser.parseString(objString);
			//element를 Json 객체로 바꿔준다아아아아!!!!!!!
			
			//System.out.println(element.getAsJsonObject().get("DESCRIPTION"));
			
			//json형식으로 바꿔진 값들을 가져오는 for문
			
			List<BikeDto> bikes = new ArrayList<BikeDto>();
			for(int i = 0; i < element.getAsJsonObject().get("DATA").getAsJsonArray().size(); i++) {
				JsonObject tmp = element.getAsJsonObject().get("DATA").getAsJsonArray().get(i).getAsJsonObject();

				
				
				

				String addr_gu = tmp.get("addr_gu").getAsString();

				int content_id = tmp.get("content_id").getAsInt();
				
	
				JsonElement content_nm_je = tmp.get("content_nm");
				
				String content_nm = content_nm_je.getAsString();
				
				JsonElement new_addr_je = tmp.get("new_addr");
				String new_addr = new_addr_je.getAsString();
				
				int cradle_count = tmp.get("cradle_count").getAsInt();
				double longitude = tmp.get("longitude").getAsDouble();
				double latitude = tmp.get("latitude").getAsDouble();
				
				BikeDto dto = new BikeDto(addr_gu, content_id, content_nm, new_addr, cradle_count, longitude, latitude);
			
				bikes.add(dto);
			}
			
			if(dao.delete()) {
				System.out.println("삭제 성공");
			}
			int res = dao.insert(bikes);
			
			if(res > 0) {
				System.out.println("저장 성공");
			} else {
				System.out.println("저장 실패");
			}
			
			response.getWriter().append(res+"");
		}
	}

}
