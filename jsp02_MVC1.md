# MVC패턴 1

>  개발을 할 때에 3가지 형태로 나누어 개발하는 방법론이다.
>
>  클라이언트가 서버에 요청을 할 때 mvc패턴을 거치고 나서 서버가 클라이언트에 응답을 하게 된다.
>
>  여기서 mvc패턴1과 mvc패턴2 가 있다.
>
>  **MVC : Model, View, Controller** 으로 구분되어 있다.
>
>  **Model** : 계산이나 연산을 처리하거나 DB에 연결해주는 역할
>
>  **View** : 사용자가 보게 될 화면
>
>  **Controller** : 어떤 화면을 보여줄지 제어를 해주는 역할
>
>  ![](https://postfiles.pstatic.net/MjAyMDA2MjdfMTgx/MDAxNTkzMjM0MzUzNTg2.n-TNLlGm8IUeunptHOdweP4g-ZbX20YSB_meIVunTNIg.YdoFySr7CleCKZ-Qm7BPlLA5zUkKoAU72LcsfGtoDkQg.JPEG.rgusqls/mvc%ED%8C%A8%ED%84%B41.jpg?type=w773)
>
>  이런 형식으로 이루어져있다.
>
>  클라이언트가 서버에 요청하면 MVC패턴을 거쳐 서버에 요청이 들어가게 되고 서버에서 DB값을 가져온 후에 MVC를 거쳐 클라이언트(View)에 보여지게 된다.
>
>  이 모습은 Controller과 Model이 섞여있는 모습이다.
>
>  
>
>  먼저 
>
>  java영역에서 패키지를 따로 만들어준다.
>
>  db패키지, dao패키지, dto패키지.
>
>  db패키지에 sql파일을 만들어준다. 만들어주는 이유는 create, insert, update, select, delete를 하기 위해서.
>
>  ```sql
>  CREATE SEQUENCE MYSEQ;
>  CREATE TABLE MYBOARD(
>  	MYNO NUMBER PRIMARY KEY,
>   MYNAME VARCHAR2(1000) NOT NULL,
>   MYTITLE VARCHAR2(2000) NOT NULL,
>   MYCONTENT VARCHAR2(4000) NOT NULL,
>   MYDATE DATE NOT NULL
>  );
>  
>  INSERT INTO MYBOARD
>  VALUES(MYSEQ.NEXTVAL, '이름', '제목', '내용', SYSDATE);
>  ```
>
>  SEQUENCE를 만들어준 이유는 번호는 만들수록 알아서 번호가 증가해야하기 때문에 만들어주었다.
>
>  MYDATE를 DATE타입으로 정하고 SYSDATE를 해주면 현재 날짜가 입력되게 된다.
>
>  위의 결과 : 
>
>  MYNO  MYNAME  MYTITLE  MTCONTENT  MYDATE
>
>  ​	1			이름		제목			내용				2020.06.27
>
>  
>
>  **이제 JDBCTemplate라는 Class를 만들어줄 차례이다.**
>
>  여기서는 드라이버 연결과 계정연결을 해주고, close와 commit, rollback메소드를 만들어서
>
>  손쉽게 사용할 수 있도록 만들어준다,
>
>  ```java
>  public class JDBCTemplate{
>   //드라이버연결과 계정연결을 해주는 메소드.
>   //1. 드라이버연결
>   //2. 계정연결
>   //3. 쿼리준비
>   //4. 쿼리 실행 및 리턴
>   //5. db종료
>   //여기서 1,2 번을 담당한다
>  
>   public static Connection getConnection(){
>       
>       //드라이버의 url을 입력해주면 된다.
>       //오류가 난다면 try/catch를 해주면 된다.
>       try{
>           //1. 드라이버연결
>       	Class.forName("");
>       } catch {
>           e.printStackTrace();
>       }
>       
>       //2. 계정연결
>       //계정의 url과 이름,비밀번호를 입력한다.
>       String url = "";
>       String user = "";
>       String pw = "";
>       
>       Connection con = null;
>       try{
>       	con = DriverManager.getConnection(url, user, pw);
>       	//setAutoCommit는 자동으로 커밋을 해주는 기능인데
>           //이를 false로 변경해주게 되면 내가 원할 때 commit를 하고 안하고를 할 수 있다.
>           con.setAutoCommit(false);
>       } catch{
>           e,printStackTrace();
>       }
>       return con;
>   }
>   
>   public static void close(Connection con){
>       try{
>           con.close();
>       }catch{
>           e.printStackTrace();
>       }
>   }
>   public static void close(Statement stmt){
>       try{
>           stmt.close();
>       }catch{
>           e.printStackTrace();
>       }
>   }
>   public static void close(ResultSet rs){
>       try{
>           rs.close();
>       }catch{
>           e.printStackTrace();
>       }
>   
>   public static void commit(Connection con){
>       try{
>           con.commit();
>       }catch{
>           e.printStackTrace();
>       }
>   }
>   public static void rollback(Connection con){
>       try{
>           con.rollback();
>       }catch{
>           e.printStackTrace();
>       }
>   }
>  
>  }
>  ```
>
>  
>
>  ------------
>
>  
>
>  이제 dto를 만들 차례이다. dto는 값을 받아오고 가져다주는 역할을 한다.
>
>  ```java
>  public class MyDto{
>   private int myno;
>   private String myname;
>   private String mytitle;
>   private String mycontent;
>   private Date mydate;
>   
>   //이제 기본생성자와 파라미터를 받는 생성자를 만들어준다.
>   public MyDto(){
>       //기본생성자
>   }
>   //파라미터를 전부 다 받는 생성자 만들기
>   public MyDto(int myno, String myname, String mytitle, String mycontent, Date 	     mydate){
>    	this.myno = myno;
>       this.myname = myname;
>       this.mytitle = mytitle;
>       this.mycontent = mycontent;
>       this.mydate = mydate;
>   }
>   //insert할 때에는 작성자와 제목 내용을 입력해야하기 때문에 파라미터 3개를 받는 생성자 생성
>   //번호는 시퀀스로 자동으로 올라가고 날짜는 자동으로 현재날짜 입력되기 때문에 써줄 필요가 없다
>   public MyDto(String myname, String mytitle, String mycontent){
>       this.myname = myname;
>       this.mytitle = mytitle;
>       this.mycontent = mycontent;
>   }
>   //update할 때에는 작성자는 수정이 안되고 제목과 내용을 수정할 것이고, 해당 글을 번호로
>   //찾아서 불러올 것이기 때문에 myno,mytitle, mycontent를 받아와야한다.
>   public MyDto(int myno, String mytitle, String mycontent){
>       this.myno = myno;
>       this.mytitle = mytitle;
>       this.mycontent = mycontent;
>   }
>   //이제 값을 가지고오고 보내줄 getter&setter을 만들어준다.
>   public int getMyno(){
>       return myno;
>   }
>   public void setMyno(int myno){
>       this.myno = myno;
>   }
>   public String getMyname(){
>       return myname;
>   }
>   public void setMyname(String myname){
>       this.myname = myname;
>   }
>   public String getMytitle(){
>       return mytitle;
>   }
>   public void setMytitle(String mytitle){
>       this.mytitle = mytitle;
>   }
>   public String getMycontent(){
>       return mycontent;
>   }
>   public void setMycontent(String mycontent){
>       this.mycontent = mycontent;
>   }
>   public Date getMydate(){
>       return mydate;
>   }
>   public void setMydate(Date mydate){
>       this.mydate = mydate;
>   }
>  }
>  ```
>
>  ------
>
>  이제 dao를 만들어줄 차례이다.
>
>  dao는 db에서 값을 가지고오게끔 도와주는 역할이다.
>
>  ```java
>  public class MyDao{
>   public List<MyDto> selectList(){
>       //JDBCTemplate에서 만들 드라이버연결, 계정연결을 사용한다.
>       Connection con = getConnection();
>       Statement stmt = null;
>       ResultSet rs = null;
>       
>       List<MyDto> list = new ArrayList<MyDto>();
>       
>      String sql = " SELECT MYNO, MYNAME, MYTITLE, MYCONTENT, MYDATE FROM MYBOARD ";
>       try{
>        	stmt = con.createStatement();
>           //3. 쿼리준비
>           //이제 쿼리를 준비를 다 했다. sql구문과 stmt를 설정해줬기 때문에.
>           
>           rs = stmt.executeQuery(sql);
>           //4. 쿼리 실행 및 리턴
>           //sql을 실행하고 이제 리턴할 것이다.
>           
>          	while(rs.next()){
>               //값들을 담을 객체를 하나 생성해준다.
>               MyDto dto = new MyDto();
>               dto.setMyno(rs.getInt(1));
>               dto,setMyname(rs.getString(2);
>               dto.setMytitle(rs.getString(3);
>               dto.setMycontent(rs.getString(4));
>               dto.setMydate(rs.getDate(5));
>               //sql구문 select부분 하나하나에 값을 담아준다.
>                              
>               list.add(dto);
>               //그리고 list배열에 dto담은 값들을 저장해준다
>           }
>       }catch{
>           e.printStackTrace();
>       } finally{
>           //5. db종료
>           //이제 가장 나중에 만들어진 순서대로 닫아준다.
>           close(rs);
>           close(stmt);
>           close(con);
>       }
>       return list;
>   }
>   public MyDto selectOne(int myno){
>       //객체 하나에 담겨진 모든 row를 가지고와야해서 MyDto타입이 되었고
>       //myno가 기본키이기 때문에 이를 가지고 값을 가져와야하기 때문에 파라미터로 받았다.
>       Connection con = getConnection();
>       PreparedStatement = pstm;
>       ResultSet rs = null;
>       
>     String sql = " SELECT MYNAME, MYTITLE, MYCONTENT FROM MYBOARD WHERE MYNO = ? ";
>     //값을 가져온 페이지를 볼 때 이름과 제목, 내용을 보기 위해서 3개만 받아왔고
>     //번호로 가져올 것이기 때문에 조건절에 MYNO를 작성했다.
>       
>       
>       try{
>       pstm = con.preparedStatement(sql);
>       //물음표 첫번째자리에 myno를 대입할것이라는 의미다.
>       pstm.setInt(1, myno);
>       
>       rs = pstm.executeQuery();
>       
>       	while(rs.next()){
>         	  dto.setMyname(rs.getString(1));
>         	  dto.setMytitle(rs.getString(2));
>             dto.setMycontent(rs.getString(3));
>       	}
>       }catch{
>           e.printStackTrace();
>       } finally{
>           close(rs);
>           close(pstm);
>           close(con);
>       }
>       return dto;
>   }
>   
>   //insert는 작성성공된 갯수를 return할 것이기 때문에 타입이 int이다.그래서 return값도
>   //int형인 res를 반환한다.
>   public int insert(MyDto dto){
>       Connection con = getConnection();
>       PreparedStatement = null;
>       
>       int res = 0;
>       
>     String sql = " INSERT INTO MYBOARD VALUES( MYSEQ.NEXTVAL, ?, ?, ?, SYSDATE ) ";
>   	
>       try{
>       pstm = con.preparedStatement(sql);
>       //물음표 순서에 하나하나의 값을 넣어주기 위해 써줬다.
>       pstm.setString(1, dto.getMyname());
>       pstm.setString(2, dto.getMytitle());
>       pstm.setString(3, dto.getMycontent());
>           
>           res = pstm.executeUpdate();
>           
>           //만약에 res가 0보다 크다는 것은 작성에 성공했다는 것을 의미한다.
>           if(res > 0){
>               commit(cpn);
>           }
>       } catch{
>           e.printStackTrace();
>       }finally{
>           close(pstm);
>           close(con);
>       }
>       return res;
>   }
>   public int update(MyDto dto){
>       Connection con = getConnecion();
>       PreparedStatement = null;
>       
>       int res = 0;
>       
>      String sql = " UPDATE MYBOARD SET MYTITLE = ?, MYCONTENT = ? WHERE MYNO = ? ";
>   
>   	try{
>           pstm = con.PreparedStatement(sql);
>           
>           pstm.setString(1, dto.getMytitle());
>           pstm.setString(2, dto.getMycontent());
>           pstm.setInt(3, dto.getMyno());
>           
>           res = pstm.executeUpdate();
>           
>           if(res > 0){
>               commit(con);
>           }
>       }catch{
>           
>       } finally{
>           close(pstm);
>           close(con);
>       }
>       return res;
>   }
>   public int delete(int myno){
>       Connection con = getConnection();
>       PreparedStatement pstm = null;
>       
>       int res = 0;
>       
>       String sql = " DELETE FROM MYBOARD WHERE MYNO = ? ";
>       
>       try{
>       	 pstm = con.preparedStatement(sql);
>           pstm.setInt(1, myno);
>           res = ptsm.executeUpdate();
>           if(res > 0){
>               commit(con);
>           }
>       } catch {
>           e.printStackTrace();
>       }finally{
>           close(pstm);
>           close(con);
>       }
>       return res;
>   }
>  }
>  ```
>
>  --------
>
>  model과 controller을 만들었다면 이제 우리가 보여질 화면을 만들어야한다.
>
>  
>
>  **[index.jsp]**
>
>  ```html
>  <%@ page language="java" contentType="text/html; charset=UTF-8"
>      pageEncoding="UTF-8"%>
>      
>      <% request.setCharacterEncoding("UTF-8"); %>
>      <% response.setContentType("text/html; charset=UTF-8"); %>
>  <!DOCTYPE html>
>  <html>
>  <head>
>  <meta charset="UTF-8">
>  <title>index</title>
>  </head>
>  <body>
>  	<jsp:forward page="./mylist.jsp"/>
>  </body>
>  </html>
>  ```
>
>  
>
>  **[mylist.jsp]**
>
>  mylist.jsp에서는 db에 저장되어있는 값들을 가져와서 글목록이라는 이름으로 화면에 보여지게 될 것이다.
>
>  ```jsp
>  <%@ page language="java" contentType="text/html; charset=UTF-8"
>      pageEncoding="UTF-8"%>
>      
>      <% request.setCharacterEncoding("UTF-8"); %>
>      <% response.setContentType("text/html; charset=UTF-8"); %>
>  <!DOCTYPE html>
>  <html>
>  <head>
>  <meta charset="UTF-8">
>  <title>글 목록</title>
>  </head>
>  <body>
>      <%
>      //우선 DB랑 연결하는 객체를 만들어준다.
>      MyDao dao = new MyDao();
>      //DB랑 연결해서 전체 ROW를 dto에 하나하나 담는다. 그걸 전무 모아서 list로 관리한다.
>      List<MyDto> list = dao.selectList();
>      %>
>      
>  	<h1>글 목록</h1>
>      <table>
>          <col width="100"/>
>          <col width="100"/>
>          <col width="300"/>
>          <col width="100"/>
>          <tr>
>          	<th>번  호</th>
>              <th>작성자</th>
>              <th>제  목</th>
>              <th>날  짜</th>
>          </tr>
>          <%
>          //list에 담긴 값들의 사이즈만큼 돌아서 db값을 가지고 올거다.
>          for(int i = 0; i < list.size(); i++){
>          %>
>          	<tr>
>                  <!-- list의 i번지는 row한 줄을 의미한다. -->
>          		<td><%=list.get(i).getMyno()%></td>
>                  <td><%=list.get(i).getMyname()%></td>
>                  <!--
>  			제목을 클릭하면 myselect.jsp로 넘어간다. 그때myno라는 값을 가지고간다는 의미이다.
>  				-->
>                  <td><a href = "myselect.jsp?myno=<%=list.get(i).getMyno()%>">										<%=list.get(i).getMytitle()%></a></td>
>                  <td><%=list.get(i).getMydate()%></td>
>          	</tr>
>          <%
>          }
>          %>
>          <tr>
>          	<td colspan="4" align = "right">
>              	<input type="button" value="글작성" 												onclick="location.href='myinsert.jsp'";
>              </td>
>          </tr>
>      </table>
>  </body>
>  </html>
>  ```
>
>  
>
>  ![](https://postfiles.pstatic.net/MjAyMDA2MjhfMTcx/MDAxNTkzMzIzNDQ4NTA3.g5n5VaPdWSwlchPIaDkFaPonT4jWX-jEK7o0dGK9HcYg.3DHD12uZlMXaKjdrV066OG3JHlVg54qlEvRV9i0oITAg.PNG.rgusqls/image.png?type=w773)
>
>  mylisyt.jsp의 결과 화면이다. 
>
>  글 작성을 클릭하면 작성 홈페이지로 넘어가는 jsp를 만들자.
>
>  **[myinsert.jsp]**
>
>  ```jsp
>  <%@ page language="java" contentType="text/html; charset=UTF-8"
>      pageEncoding="UTF-8"%>
>      
>      <% request.setCharacterEncoding("UTF-8"); %>
>      <% response.setContentType("text/html; charset=UTF-8"); %>
>  <!DOCTYPE html>
>  <html>
>  <head>
>  <meta charset="UTF-8">
>  <title>index</title>
>  </head>
>  <body>
>      <h1>글작성</h1>
>  	<form action="insertRes.jsp" method="post">
>          <table border="1">
>              <tr>
>              	<th>이름</th>
>                  <td><input type="text" name="myname"</td>
>              </tr>
>              <tr>
>              	<th>제목</th>
>                  <td><input type="text" name="mytiitle"</td>
>              </tr>
>              <tr>
>              	<th>내용</th>
>                  <td><textarea rows="10" cols="60" name="mycontent"></textarea></td>
>              </tr>
>              <tr>
>              	<td>
>                  	<input type="button" value="취소" 														onclick="location.href='mylist.jsp'"/>
>                      <input type="submit" value="글 작성"/>
>                  </td>
>              </tr>
>          </table>
>      </form>
>  </body>
>  </html>
>  ```
>
>  ![](https://postfiles.pstatic.net/MjAyMDA2MjhfMTk0/MDAxNTkzMzI0MDE0MjQx.NnJhAgmP44tq-UmfSkcF61SgV06m5WaJExUWEjC2Lo4g.PEic_YknGZZv8M4ECvXCIoWjxZ2-PI-4J-lgR-2gPlgg.PNG.rgusqls/image.png?type=w773)
>
>   글작성 버튼을 누르면 위와같은 테이블이 화면에 보여지게 된다.
>
>  input태그에  name을 준 것은 입력한 값들을 다른 곳에서 가지고올 수 있게 하기 위해서다.
>
>  이제 내용을 입력하고 글작성을 눌렀을 때 입력한 데이터 값들을 db에 저장하고 다시
>
>  mylist.jsp로 넘어가야한다.그 전에 db에 값을 저장하는 jsp를 만들자.
>
>   
>
>  **[ myinsertRes.jsp ]**
>
>  ```jsp
>  <%@ page language="java" contentType="text/html; charset=UTF-8"
>      pageEncoding="UTF-8"%>
>      
>      <% request.setCharacterEncoding("UTF-8"); %>
>      <% response.setContentType("text/html; charset=UTF-8"); %>
>  <!DOCTYPE html>
>  <html>
>  <head>
>  <meta charset="UTF-8">
>  <title>index</title>
>  </head>
>  <body>
>      <%
>      //먼저 insert.jsp에서 text를 입력하고 submit한 값들을 받아와야한다.
>      String myname = request.getParameter("myname");
>      String mytitle = request.getParameter("mytitle");
>      String mycontent = request.getParameter("mycontent");
>      //파라미터 3개를 받는 생성자를 만들어놨기 때문에..
>      //dto는 값들을 전달해주는 역할이다.
>      MyDto dto = newMyDto(myname, mytitle, mycontent);
>      
>      //dao를 쓸 수 있게 객체를 생성해준다
>      //dao는 드라이버연결, 계정연결 우리가 필요한 5가지 일울 해주는 역할이다.
>      MyDao dao = new MyDao();
>      
>      //insert는 리턴타입이 int이다. 작성성공한 결과값이 row갯수를 리턴하기 때문에
>      //int이고, dao의 insert 메소드를 실행하는데 받아올 값이 dto이기 때문에 파라미터로 넣어준다.
>      int res = dao.insert(dto);
>      
>      if(res > 0){
>      %>
>      <script type="text/javascript">
>      alert("작성에 성공했습니다");
>      location.href="mylist.jsp";
>      </script>
>      <%
>      } else {
>      %>
>      <script type="text/javascript">
>      alert("작성에 실패했습니다.");
>      location.href="myinsert.jsp";
>      </script>
>      <%
>      }
>      %>
>  	
>  </body>
>  </html>
>  ```
>
>  --------
>
>  이제 제목을 클릭했을 때 상세보기가 가능한 창을 만들자
>
>  **[ myselect.jsp ]**
>
>  ```jsp
>  <%@ page language="java" contentType="text/html; charset=UTF-8"
>      pageEncoding="UTF-8"%>
>      
>      <% request.setCharacterEncoding("UTF-8"); %>
>      <% response.setContentType("text/html; charset=UTF-8"); %>
>  <!DOCTYPE html>
>  <html>
>  <head>
>  <meta charset="UTF-8">
>  <title>글 작성</title>
>  </head>
>  <body>
>  	<%
>      //mylist.jsp에서 a태그은 제목을 클릭했을 때에는 myno값을 넘겨준다.
>      //넘겨준 값을 받아야한다.
>      //html에선 모든 값이 문자열로 넘어오기 때문에 int형식으로 형변환 해주고 넣어줘야한다.
>      int myno = Integer.parseInt(request.getParameter("myno"));
>      
>      MyDao dao = new MyDao();
>      MyDto dto = dao.selectOne(myno);
>      %>
>      <table border="1">
>          <tr>
>          	<th>이름</th>
>              <td><%=dto.getMyname()%></td>
>          </tr>
>          <tr>
>          	<th>제목</th>
>              <td><%=dto.getMytitle()%></td>
>          </tr>
>          <tr>
>          	<th>내용</th>
>              <td><%=dto.getMycontent()%></td>
>          </tr>
>          <tr>
>              <td>
>              	<input type="button" value="확인" 															onclick="location.href='mylist.jsp'"/>
>                  <input type="button" value="수정" 															onclick="location.href='myupdate.jsp?myno=<%=myno%>'"/>
>                  <input type="button" value="삭제" 															onclick="location.href='mydelete.jsp?myno=<%=myno%>'"/>
>              </td>
>          </tr>
>      </table>
>  </body>
>  </html>
>  ```
>
>  ----------
>
>  상세보기 화면에서 확인버튼을 클릭하면 mylist.jsp로 돌아간다.
>
>  수정을 누르면 myupdate.jsp를 myno값을 가지고 갈 것이고
>
>  삭제를 누르면 mydelete.jsp를 myno값을 가지고 갈 것이다.
>
>  **[  myupdate.jsp ]**
>
>   ```jsp
>  <%@ page language="java" contentType="text/html; charset=UTF-8"
>      pageEncoding="UTF-8"%>
>      
>      <% request.setCharacterEncoding("UTF-8"); %>
>      <% response.setContentType("text/html; charset=UTF-8"); %>
>  <!DOCTYPE html>
>  <html>
>  <head>
>  <meta charset="UTF-8">
>  <title>글 수정</title>
>  </head>
>  <body>
>  	<%
>      int myno = Integer.parseInt(request.getParameter("myno"));
>      
>      MyDao dao = new MyDao();
>      //상세보기글을 그대로 가져와야하기 때문에 selectOne메소드를 사용하였다.
>      MyDto dto = dao.selectOne(myno);
>      %>
>      <form action="myupdateRes.jsp" method="post">
>          <table border="1">
>              <tr>
>              	<th>이름</th>
>                  <td><input type="text" readonly="readonly"
>                             value="<%=dto.getMyname()%>"</td>
>              </tr>
>              <tr>
>              	<th>제목</th>
>                  <td>
>                      <!-- value값에 <%%>를 넣어준 이유는 원래 있던 값을 가져오기 위함 -->
>                      <input type="text" name="mytitle" value="<%=dto.getMytitle()%>"
>                  </td>
>              </tr>
>              <tr>
>              	<th>내용</th>
>                  <td><textarea rows="10" cols="60" name="mycontent">
>                      <%=dto.getMycontent()%>
>                      </textarea></td>
>              </tr>
>              <tr>
>                  <td>
>                  	<input type="submit" value="수정완료"/>
>                      <input type="button" value="취소" 															onclick="location.href='myselect.jsp?myno=<%=myno%>'"/>
>                  </td>
>              </tr>
>          </table>
>      </form>
>      
>      
>  </body>
>  </html>
>   ```
>
>  --------------
>
>  텍스트를 수정하고 수정완료를 누르면 form태그 안의 것들이 action안에 있는 경로로 이동한다.
>
>  이제 myupdateRes.jsp를 만들어서 값을 가지고 처리를 해야한다.
>
>  **[ myupdateRes.jsp ]**
>
>   ```jsp
>  <%@ page language="java" contentType="text/html; charset=UTF-8"
>      pageEncoding="UTF-8"%>
>      
>      <% request.setCharacterEncoding("UTF-8"); %>
>      <% response.setContentType("text/html; charset=UTF-8"); %>
>  <!DOCTYPE html>
>  <html>
>  <head>
>  <meta charset="UTF-8">
>  <title>index</title>
>  </head>
>  <body>
>  	<%
>      //우선 넘겨준 번호값과, text에 입력해서 넘겨준 값들을 가져와야한다.
>      int myno = Integer.parseInt(request.getParameter("myno"));
>      String mytitle= request.getParameter("mytitle");
>      String mycontent=request.getParameter("mycontent");
>      MyDto dto = new MyDto(myno, mytitle, mycontent);
>      
>      MyDao dao = new MyDao();
>      int res = dao.update(dto);
>      
>      if(res > 0) {
>      %>
>      <script type="text/javascript">
>      alert("수정에 성공했습니다.");
>      location.href="myselect.jsp?myno=<%=myno%>";
>      </script>
>      <%
>      } else {
>      %>
>      <script type="text/javascript">
>      alert("수정에 실패했습니다.");
>      location.href="myupdate.jsp?myno=<%=myno%>";
>      </script>
>      <%
>      }
>      %>
>  </body>
>  </html>
>   ```
>
>  --------
>
>  이제 삭제버튼을 누르면 데이터를 삭제해주는 jsp를 만들어야한다.
>
>  **[  mydelete.jsp ]**
>
>  ```jsp
>  <%@ page language="java" contentType="text/html; charset=UTF-8"
>      pageEncoding="UTF-8"%>
>      
>      <% request.setCharacterEncoding("UTF-8"); %>
>      <% response.setContentType("text/html; charset=UTF-8"); %>
>  <!DOCTYPE html>
>  <html>
>  <head>
>  <meta charset="UTF-8">
>  <title>index</title>
>  </head>
>  <body>
>  	<%
>      //삭제버튼을 클릭했을 때 번호를 전달해줬기 때문에 번호를 받아온다.
>      int myno = Integer.parseInt(request.getParameter("myno"));
>      MyDto dto = new MyDto();
>      int res = dao.delete(myno);
>      
>      if(res > 0){
>      %>
>      <script type="text/javascript">
>      alert("삭제 성공했습니다.");
>     	location.href="mylist.jsp";
>      </script>
>      <%
>      } else {
>      %>
>      <script type="text/javascript">
>      alert("삭제 실패했습니다.");
>      location.href="myselect.jsp?myno=<%=myno%>";
>      </script>
>      <<%
>      }
>      %>
>  </body>
>  </html>
>  ```
>
>  
>
>   
>
>   MVC1 패턴으로 게시판을 아주 간단하게 만들어 보았다.
>
>  MVC1패턴은 Model과 controller를 섞어놓은 것이다.
>
>  계산연산처리와 어떤 화면을 보여줄지 섞어서 jsp를 만들었는데
>
>  MVC2 패턴은 확실하게 구분시켜놓은 것이다.
>
>  다음 파일에서 MVC2패턴을 해보겠따!!!!!

