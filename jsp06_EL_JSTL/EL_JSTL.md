# EL

>  EL이란 Expression Language의 약자이다.
>
>  jsp가 가지고 있는 내장언어라고도 한다. <%=%>으로 값을 가져왔었는데 이보다 훨씬 더 쉽게 할 수 있다.
>
>  삼항연산자도 가능하며 산수를 제공해주고 Attribute형식에서는 ${}으로 사용이 가능하다.
>
>  controller에서 Attribute로 전해준 값을 사용한다.
>
>  만일 list로 불러왔다면 ${list.name} 으로 사용할 수 있다. 이의 의미는 list에 담겨있는 name라는 곳에
>
>  담겨있는 값을 출력한다.
>
>  list.name은 list.getList()와 동일하다. 필드값이 아니라 getter Method를 호출하는 것이다.
>
>  대신 표기법은 getList 처럼 작성해야한다.
>
>  ```jsp
>  ${(Attribute로 받아온 객체의 이름.변수명)} 의 형식으로 사용할 수 있다.
>  ```
>
>  EL을 사용하기 앞서  C:\TomCat\webapps\examples\jsp\jsp2\el => basic-arithmetic.jsp을 WebContent 밑으로 끌어와야 한다.
>
>  
>
>  
>
>  #  JSTL
>
>  JSP Standard Tag Library라고 부른다.
>
>  jsp에서는 일반적으로 HTML 안에 <%%>를 사용하여 자바를 사용할 수 있었다.
>
>  하지만 이는 코드가 복잡해 보일수가 있다. 그래서 나온 것이 JSTL이라고 할 수 있다.
>
>  HTML내에서도 <%%>를 사용하지 않아도 태그 그 자체로 JAVA 태그를 사용할 수 있다.
>
>  다른 말로는 아파치에서 제공해주는 태그 모음집이라고도 볼 수 있겠다.
>
>  JSTL을 사용하기 위해서는 아래왜 같은 것을 작성해줘야한다.
>
>  CORE LIBRARY
>   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
>
>  XML LIBRARY
>   <%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
>
>  FMT LIBRARY 
>   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
>
>  SQL LIBRARY
>   <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
>
>  FUNCTIONS LIBRARY
>   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
>
>  
>
>  | 속성분류  |   속성    |                             설명                             |
>  | :-------: | :-------: | :----------------------------------------------------------: |
>  | 변수 설정 |    set    |                   JSP에서 사용될 변수 설정                   |
>  | 변수 설정 |  remove   |                      설정한 변수를 제거                      |
>  | 흐름제어  |    if     |     if문으로 else if가 업소 하나의 조건을 처리할 때 사용     |
>  | 흐름제어  |  choose   | 다중 조건을 사용할 때 사용(Switch의 시작과 끝을 맺을 수 있음) |
>  | 흐름제어  |   when    |               Switch문에서의 case같은 존재이다               |
>  | 흐름제어  | otherwise |             Switch문에서의 default같은 존재이다              |
>  | 흐름제어  |  forEach  |              java에서의 for문, forEach문과 동일              |
>  | 흐름제어  | forTokens |          java의 StringTokenizer클래스의 역할과 동일          |
>  | 외부처리  |  import   |            URL을 사용하여 다른 자원의 결과를 삽임            |
>  | 외부처리  | redirect  |                      지정한 경로로 이동                      |
>  | 외부처리  |    url    |                           URL작성                            |
>  |   기타    |   catch   |                           예외처리                           |
>  |   기타    |    out    |      JspWriter클래스의 역할과 동일 (출력문이라고 생각)       |
>
>  * set속성을 사용하여 변수 선언 방법
>
>  ```
>  <c:set var = "변수명" value="값"/>
>  ```
>
>   **비교연산자**
>
>  | JAVA | JSTL |
>  | :--: | :--: |
>  |  ==  |  eq  |
>  |  !=  |  ne  |
>  |  <   |  lt  |
>  |  >   |  gt  |
>  |  <=  |  le  |
>  |  >=  |  ge  |

