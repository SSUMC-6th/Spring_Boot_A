### 웹 서버 아키텍쳐의 구조

---

다양한 구조를 가질 수 있다.

- 1) Client -> Web Server -> DB
- 2) Client -> WAS -> DB
- 3) Client -> Web Server -> WAS -> DB

### 3번 구조의 동작 과정

---

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/f1912130-0409-4e90-a90f-6091ae253e73/b02c0e1c-a828-43a7-a912-d9f2f1c45d22/Untitled.png)

1. `Web Server`는 웹 브라우저 클라이언트로부터 HTTP 요청을 받는다.
2. `Web Server`는 클라이언트의 요청(Request)을 WAS에 보낸다.
3. `WAS`는 관련된 Servlet을 메모리에 올린다.
4. `WAS`는 web.xml을 참조하여 해당 Servlet에 대한 Thread를 생성한다. (Thread Pool 이용)
5. HttpServletRequest와 HttpServletResponse 객체를 생성하여 Servlet에 전달한다.
    
    5-1. Thread는 Servlet의 service() 메서드를 호출한다.
    
    5-2. service() 메서드는 요청에 맞게 doGet() 또는 doPost() 메서드를 호출한다.
    
    ```jsx
    protected doGet(HttpServletRequest request, HttpServletResponse response)
    ```
    
6. doGet() 또는 doPost() 메서드는 인자에 맞게 생성된 적절한 동적 페이지를 Response 객체에 담아 `WAS`에 전달한다.
7. `WAS`는 Response 객체를 **HttpResponse** 형태로 바꾸어 `Web Server`에 전달한다.
8. 생성된 Thread를 종료하고, HttpServletRequest와 HttpServletResponse 객체를 제거한다.