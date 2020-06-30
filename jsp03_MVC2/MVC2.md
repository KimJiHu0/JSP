# MVC2

>  **MVC1패턴**은 Model과 Controller을 섞어서 사용했다.
>
>  **MVC2패턴**은
>
>  Model과 View, Controller을 명확하게 구분을 해준 것이다.
>
>  Client가 Server에 request하면 무조건 Controller을 거쳐서 DB에서 값을 가져오고 Controller에서 View에
>
>  보내주어야 한다.
>
>  ![](https://postfiles.pstatic.net/MjAyMDA2MzBfNjQg/MDAxNTkzNTAzMDkzODU4.ev4kTQVTZzJkhe-T7BJmFflLo-5fCU4wMsBpD3QyB4Eg.2yZuzem-cGYv1UcGXZlW_vSiAM9FJkc7gW2S2VoqS7wg.PNG.rgusqls/image.png?type=w773)
>
>  MVC2가 실행되는 모습니다.
>
>  클라이언트가 요청을 하면 컨트롤러가 데이터베이스에 값을 가지고 오고 뷰로 넘겨준다.
>
>  컨트롤러를 무조건!!!!!!!!!!! 거쳐야한다.
>
>  MVC1과 다르게 명확하게 구분을 시켜준 이유는 오류가 났을 때 찾기가 쉽고, 성능이 좋아지고
>
>  유지보수하기가 쉬워진다.