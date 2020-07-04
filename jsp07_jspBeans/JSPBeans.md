# JSP:Beans

>  getter & setter을 가지는 표현 객체라고 볼 수 있다.
>
> java파일로 class파일(객체)를 설계한 후에 jsp에서 필요에 따라서 가져다가 쓸 수 있는데
>
> 이를 class bean이라고 부른다.
>
> ```jsp
> <jsp:useBean id="변수명" class="패키지명.클래스명" scope="범위"></jsp:useBean>
> ```
>
> 사용을 할 것인데 **id는 변수이름을 가지고** **class파일은 [패키지명.클래스명]**에서 가져올 것이다.
>
> **scope는 범위를 얘기하는데 page, request, session, application**을 쓸 수 있다.
>
> **page :** 해당 페이지까지만 객체유지
>
> **request :** 요청한 페이지까지 객체유지
>
> **session :** 만료전까지 객체유지
>
> **application :** 패키지 내에서는 객체 유지
>
> scope는 id가 를 찾기 위해서 page부터 application까지 찾을 것이다.
>
> 
>
> 위에서 작성된 뜻은 **[ Score sc = new Score() ]**처럼 객체생성하는 것과 똑같다.
>
>  Bean을 사용하기 위해서는 class파일에 **getter과 setter을 만들어야 한다.**
>
>  
>
>  ```jsp
> //set사용
> <jsp:setProperty property="name" name="sc" value="콩길동"/>
> //get사용
> <jsp:getProperty property="name" name="sc"/>
>  ```
>
>  위와 같이 사용한다고 만들어 set과 get을 사용 할 수 있다.
>
> **set**은 값을 설정해주는 것이라고 볼 수 있으며 **get**은 값을 가져와서 사용한다는 의미이다.
>
> get/set을 사용할 때에는 주의할 점이 있다. FORM과 JAVA안의 변수명과 Beans에서의
>
> set/get의 프로퍼티이름은 동일해야한다. 대소문자를 구분하는 것을 주의해야한다.
>
> 
>
>  이번 예제에서는 setAttribute로 이름을 지정해주고 
>
>  
>
>  
>
>  
>
> 

