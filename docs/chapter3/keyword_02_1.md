### WAS란?

---

- 요청이 올 때마다 해당 요청에 적절한 (동적인) 콘텐츠를 만들어 응답하는 서버
- DB 조회 등 다양한 로직 처리를 요구하는 동적인 컨텐츠를 제공하기 위해 만들어짐
- “`Web Container`” 혹은 “`Servlet Container`”라고도 불린다.
    - 이때 Container란 JSP, Servlet을 실행시킬 수 있는 소프트웨어를 말한다.
    - 즉, WAS는 JSP, Servlet 구동 환경을 제공한다.
- ex) Node.js, SpringBoot, Apache Tomcat

### WAS의 주요 기능

---

- 프로그램 실행 환경과 DB 접속 기능 제공
- 여러 개의 트랜잭션(논리적인 작업 단위) 관리 기능
- 업무를 처리하는 비즈니스 로직 수행