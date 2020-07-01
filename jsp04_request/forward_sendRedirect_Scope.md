# forward

>  ![](https://postfiles.pstatic.net/MjAyMDA3MDFfNjQg/MDAxNTkzNjEwMTE3NjU3.1XFBh_Ljhu0Tz_Deen4mHzFakz_QL_rIBdrEj-5dX4cg.6qG6_arLUPQetFzNIv9BaP8K0UhrNqoD0wrPcHoQ3Oog.JPEG.rgusqls/forward.jpg?type=w773)
>
>  forward는 위와 같은 식으로 실행이 된다.
>
> 클라이언트에서 서버로 request한다. 클라이언트에서 request한 값은 요청한페이지인 server까지만 유효하기 때문에 forward를 사용해줘서 request의 객체를 유지하면서 controller를 지나 다른 곳까지 갈 수 있게 만들어준다.
>
> 1.클라이언트가 server에 request한다.
>
> 2,서버는 다른곳으로 요청을 한다. 이 때 request 객체는 원래 요청한 페이지인 server에서까지만 유효하고
>
> 사라지는데 forward를 써줌으로써 controller의 다음페이지까지 request의 객체가 유지된다.
>
> 그리고 그 곳에서 다시 controller로 응답하고 controller에서 client로 응답하게 되는 시스템이다.
>
> 간단하게 정의하자면
>
> **request** : 요청한 곳까지만 객체가 유효하다.
>
> **forward** : 요청한 곳에서 다음 페이지까지 객체를 유지시켜준다.
>
>  
>
> ------
>
> # sendRedirect
>
>  ![](https://postfiles.pstatic.net/MjAyMDA3MDFfNzQg/MDAxNTkzNjEwMTIwMDgx.H4ts3Kxx_rUbezOWeHJwC1fmseCVSAZCsP9-3RDkAdEg.aLpKU3ZDX4XreN_ALs3KZvGX5lYWY8Zeu8qsWQN7uQYg.JPEG.rgusqls/sendRedirect.jpg?type=w773)
>
> 1. 클라이언트가 서버에 요청을 한다.
> 2. 클라이언트는 서버에 응답하지 않고 다른 곳으로 재요청을 한다.
> 3. 요청을 받은 곳에서 응답을 한다.
>
> 이렇게 되면 1번과 2번의 요청과 응답이 / 3번과 4번의 요청과 응답이 다른 쌍을 이루게 된다.
>
> sendRedirect란 재요청을 하는 것과 같다고 볼 수 있다.
>
>  
>
>  
>
>  
>
> **pageContext :** 현재 페이지에서 객체를 전달(현재 페이지에서만)
>
> **request :** 현재페이지에서 요청한 다음페이지(sever)까지만 객체전달(요청한 페이지(server))까지만
>
> **session :** 현재 브라우저에서 context내에 있는 모든 페이지의 객체 유지
>
> **application :** 현재 context 내에서 객체유지(같은 프로젝트 내)