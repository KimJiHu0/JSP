# Servlet

>  java안에 html문장을 만들어서 자바코드 안에서 html문서를 하나하나 문자열로 만들어주는 것이라고 한다.
>
> 웹프로그래밍에서 클라이언트가 요청을 하면 서버 안에있는 servlet가 정적인 것을 동적으로 만들어준다.
>
> 일반적으로 웹서버는 정적인 페이지만 제공한다. 그래서 동적인 페이지를 제공하기 위해서 웹서버는 다른
>
> 곳에 도움을 요청하여 동적인 페이지를 작성해야한다.
>
> 웹서버가 동적인 페이지를 제공할 수 있도록 도와주는 것이 Servlet이다.
>
> - 보통 Servlet이 MVC패턴에서 Controller로 이용된다.
> - Java thread를 이용하여 동작한다.
> - html을 사용하여 요청을 응답한다.
>
> WAS : 동적인 파일을 컴파일 해준다.(만들어져있지 않는 것들)
>
> WS : 정적인 파일을 컴파일 해준다.(이미 만들어져있는 것들)
>
> ![](https://postfiles.pstatic.net/MjAyMDA3MDJfNTkg/MDAxNTkzNjczNDM3Mjkw.jcgXrh1bSf4dLgQV2ELkXp2ZLOucc2U1lTsHPRlmhIwg.bfwu6462wRRL_2wfzcwIBj8HjWDzqbrX5XRwTpt5ms8g.PNG.rgusqls/image.png?type=w773)
>
>   Servlet의 기본 구조이다.
>
> 클라이언트가 요청을 하면 Servlet은 객체를 생성하고 xml파일을 분석하고 찾은 Servlet으로 갔다가
>
> biz로 연산처리 후 Get방식인지 Post방식인지 판별 후 그에 맞는 메소드를 실행하고 응답을 해준다.
>
>  
>
>  
>
>  
>
> 바로 전에 올린것과 다른점은 controller가 jsp이냐 servlet이냐 이다.
>
> controller가 jsp이라면 
>
> index.jsp -> server -> controller.jsp -> server -> controller.jsp -> 찾아갈.jsp
>
> jsp는 Server이 아니다. 동적인 페이지이기 때문에 Server를 2번 들릴 수밖에 없다.
>
> Servlet는 Server이다.
>
> index.jsp -> Servlet -> 요청한.jsp 식으로 간다.
>
> Servlet에서는 정적인 파일을 W.S에서 컴파일을 해주고, 만약 하지 못하면 WAS로 넘어간다.
>
> 이를 Servlet가 해준다.