**MyBatis :** 퍼시스턴스 프레임워크.
반쯤 만들어진 것인데 **sql만 우리가 구현**하면 된다.
jdbc(java와 db를 연동시키는 부분들, 반복되는 부분들을 묶어서 만들어준 것)
이 부분들을 MyBatis가 대신 실행해 줄테니, **SQL구문**에 집중하라고 만들어진 것.

[**MyBaits순서**]

1. **SqlMapConfig :** sqlSessionFactory를 return. sqlSessionFactory를 build하기 위한 객체생성.
2. **config.xml :** MyBaits의 전반적인 설정들이 들어간다. DataSource 데이터베이스와 연결.
   -typeAlias, Mapper
3. **mapper.xml :** SQL문 전달해주는 것. SQL문을 여기에 작성한다.

[**MyBaits 주요 구성 요소**]

- **configuration file** : 
  - MyBatis의 작업 설정을 설명하는 xml파일.
  - 데이터베이스 연결 대상, mapping 파일의 경로, 작업설정 등과 같은 세부사항 설명
- **SqlSessionFactoryBuilder** : 
  - MyBatis 구성파일을 읽고 생성하는 SqlSessionFactory.
- **SqlSessionFactory** :  
  - SqlSession을 생성하는 구성요소
- **SqlSession** : 
  - SQL실행 및 트랜잭션 제어를 위한 API를 제공하는 구성요소
  - 데이터베이스에서 엑세스 할 때 가장 중요한 역할을 하는 구성요소
- **Mapper** : 
  - SQL 매핑설정을 설명하는 XML파일

MyBatis를 이용하기 위해서는
**mybatis-3.5.5.jar파일을 lib에 넣어주어야한다.**