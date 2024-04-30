# 3주차 키워드 정리

---

## Web Sever

Web Server는 웹사이트에 대한 컨텐츠(데이터)를 저장하고 이를 요청하는 클라이언트에게 전달하는 역할을 한다. (여기서 말하는 컨텐츠에는 텍스트, 이미지, 영상 등이 있다.)

클라이언트 역할을 맡는 주체는 대부분 `웹 브라우저(Web Browser)`이며, 이 `웹 브라우저`는 브라우저를 사용하는 사람이 `웹 브라우저`를 통해 표시된 페이지의 특정 링크를 클릭하거나 문서를 다운로드하는 등의 작업을 할 경우 요청을 하는 방식이다.

![정적 컨텐츠를 제공하는 웹 서버](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/3721701e-af62-4d30-b524-aa80de86e02e)

정적 컨텐츠를 제공하는 웹 서버

Web Server와 Web Browser 간의 통신은 `HTTP`(보안을 생각하여 `HTTPS`도 사용함)를 사용하여 통신하게 되며, 웹 페이지의 데이터는 HTML로 인코딩된다. 이러한 페이지 컨텐츠는 정적(static)일 수도, 동적(dynamic)일 수도 있다. 다만, 동적 컨텐츠의 경우 CGI나 WAS를 이용하여야 한다.

### 참고 사이트

https://www.nginx.com/learn/web-server/

https://en.wikipedia.org/wiki/Web_server

## Web Application Server

Web Application Server(WAS), 다른 말로 Application Server는 비즈니스 로직을 통한 동적 콘텐츠를 생성하여 이를 기존의 웹 서버의 기능에 더하여 클라이언트에게 제공하는 역할을 한다.
WAS의 클라이언트는 애플리케이션, Web Server이거나 또다른 WAS일 수도 있다.

WAS와 클라이언트의 통신 방식은 Web Server와 동일하며, Web Server의 기능 대부분을 WAS에서도 지원한다.

WAS 단독으로 사용할 경우, 정적 콘텐츠와 동적 콘텐츠를 모두 처리해야 하므로 부하가 높게 걸려 동적 컨텐츠 제공에 지연이 발생할 수 있다. 이는 서비스 품질의 하락이므로, Web Server와 WAS를 함께 구축한 후, 리버스 프록시 방식을 통해 둘을 연결하여 정적 콘텐츠 제공은 Web Server가, 동적 콘텐츠 제공은 WAS가 하는 방식으로 구축을 할 수 있다.

![Web Server와 Web Application Server를 모두 이용하여 구축한 경우(출처: https://ssdragon.tistory.com/60)](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/e9f2ebf8-6d4b-419a-913a-0c300e8bbfb4)

Web Server와 Web Application Server를 모두 이용하여 구축한 경우(출처: https://ssdragon.tistory.com/60)

### 참고 사이트

https://www.nginx.com/learn/app-server/

[https://en.wikipedia.org/wiki/Web_server](https://yozm.wishket.com/magazine/detail/1780/)

https://ssdragon.tistory.com/60

## Reverse Proxy

Reverse Proxy는 클라이언트의 요청을 받아 해당 요청을 실제 웹 서버에게 포워딩하는 역할을 하는 프록시 서버이다.

프록시 서버(Proxy Server)에 대해 먼저 알아보자.

> `Proxy Server`란?
> `프록시 서버(Proxy Server)`는 클라이언트가 리소스를 요청하는 클라이언트와, 해당 리소스를 제공하는 서버의 중개자 역할을 하는 서버를 말한다.
> <br />프록시 서버를 이용해 프라이버시, 보안, 성능 향상 등을 얻을 수 있다.
> <br /> <br />
> ==짤막 영어 공부==
> <br />
> Proxy: 대리, 위임


이러한 프록시 서버의 경우, 위치한 네트워크나 제공하는 데이터의 방향(direction of traffic)에 따라 Forward Proxy와 Reverse Proxy로 나눌 수 있다.

> 개인적으로, 위치한 네트워크로 분류하는 게 더 와닿는 구분이었다.

### Forward Proxy

흔히 ‘프록시 서버’라고 말하면 대개 Forward Proxy를 뜻한다. Forward Proxy는 클라이언트 측 네트워크에 위치한 프록시 서버로, 클라이언트가 인터넷을 통해 웹 서버에 요청을 보내면, 해당 요청을 프록시 서버가 받아서 이를 다시 웹 서버에게 전송한다. 마찬가지로, 응답의 경우에도 바로 클라이언트에게 전달되지 않고, 프록시 서버가 먼저 응답을 받은 후 클라이언트에게 이를 전달한다.

Forward Proxy의 경우, 특정 조직에 속한 사람들이 웹 사이트에 직접적으로 방문하는 것을 방지하고, 나아가 특정 컨텐츠에 접근하는 것을 막을 수 있다.

장점으로는 Forward Proxy를 사용할 경우 사설 IP처럼 실제 요청자의 정보가 아닌, 프록시 서버가 대신 사용되므로 개인정보 보호 측면에서 이점이 있다.

![Forward Proxy의 예시](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/15ba97aa-482a-40ca-a372-00a22f6cc5a1)

### Reverse Proxy

Reverse Proxy는 서버 측 네트워크에 위치한 프록시 서버로, 클라이언트가 인터넷을 통해 웹 서버에 요청을 보내면, 해당 요청을 프록시 서버가 받아서 이를 적절한 서버에 포워딩한다. 마찬가지로, 응답의 경우에도 바로 클라이언트에게 전달되지 않고, 프록시 서버가 먼저 응답을 받은 후 클라이언트에게 이를 전달한다.

Reverse Proxy의 경우, 로드 밸런싱(Load Balancing)에 사용될 수 있다. 여러 웹 서버를 구축한 후, 프록시 서버 한 대를 사용함으로써, 대량의 트래픽이 발생하여도 각 서버들이 과부하되지 않도록 적절하게 요청을 분배할 수 있다.

장점으로는 Forward Proxy와 비슷하게 서버의 IP 주소를 노출시키지 않아도 된다. 프록시 서버의 IP 주소가 노출되는 것이기 때문이다. 이는 해커들의 DDoS 공격으로부터 웹 서버가 자유로워질 수 있다는 이점이 있다.(물론, IP 주소가 노출되는 프록시 서버가 DDoS 공격을 대신 받게 되긴 한다.)

![Reverse Proxy의 예시](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/24b23a32-4702-42e5-b15d-c7ad9eece03d)

### 참고 사이트

https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/

[https://losskatsu.github.io/it-infra/reverse-proxy/#2-포워드-프록시forward-서버란](https://losskatsu.github.io/it-infra/reverse-proxy/#2-%ED%8F%AC%EC%9B%8C%EB%93%9C-%ED%94%84%EB%A1%9D%EC%8B%9Cforward-%EC%84%9C%EB%B2%84%EB%9E%80)