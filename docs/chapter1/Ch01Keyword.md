# 1주차 키워드 정리

---

## TCP

TCP는 전송 계층에서 사용하는 프로토콜 중 하나인 `Transmission Control Protocol`의 약자이다.
TCP는 신뢰성 있는 데이터 전송을 제공하며, 연결 지향적인 성격을 가진다.

신뢰성 있는 데이터 전송의 경우, 네트워크 문제 등으로 인해 수신자가 데이터를 수신받지 못한 경우에 대해 대처하고, 데이터의 순서가 꼬여 수신자가 이를 알아보기 힘들게 만드는 경우를 방지한다.

TCP에서는 전송하는 세그먼트의 맨 첫번째 바이트의 순번을 나타내는 `Sequence number(seq)`를 이용해 수신자가 자신이 받은 세그먼트들의 순서를 알 수 있다.
또한, 수신자는 전달받은 세그먼트마다 다음 sequence number를 알려주기 위해, `Acknowledgment number`를 담은 ACK 응답을 송신자에게 전송한다. 송신자는 이 ACK 응답을 받지 못하면, “수신자가 내 데이터를 제대로 전달받지 못해서 답장을 안하는구나.” 라고 생각하고, 재전송을 하는 방식을 가진다.

TCP는 3가지의 Control 기능을 제공하고 있다.
- **오류 제어(Error Control)**
- **흐름 제어(Flow Control)**
- **혼잡 제어(Congestion Control)**

**오류 제어**는 패킷의 손실과 순서의 뒤섞임 등을 방지하는 것으로, 이미 위에서 설명한 내용이다. 이때 ACK 응답을 받지 못한 경우 재전송을 하는 방식에는 자세한 메커니즘이 있는데, 아래 내용을 간단히 읽어보고, 더 궁금하다면 ‘Go-back-N’과 ‘Selective repeat’ 방식을 찾아보자.

> **ACK 응답을 받지 못하는 경우?**
> <br />ACK 응답을 받지 못하는 이유에는 1) 패킷 에러, 2) 패킷 유실의 경우가 있다. 각각에 따른 해결 방식으로 Feedback + 재전송과, Timeout을 이용하는 방식 등이 있다.
>하지만, 이 방식은 하나의 패킷에 대한 대응이므로 Sender가 하나의 패킷을 보내고 다음 ACK가 올 때까지 기다리는 상황이 발생하여 성능 저하가 일어난다.
>즉, 이를 향상시키기 위해 한 번에 여러개의 패킷을 전송하고 다시 여러 개의 ACK를 받는 pipelining 방식을 이용한다. 이 pipelining 방식을 구현한 메커니즘은 
>‘Go-back-N’, ‘selective repeat’ 방식이 있으며, 실제 TCP에서는 2개의 방식의 장점을 절충한 hybrid 방식을 사용한다.

**흐름 제어**는 송신자와 수신자가 각각 데이터를 처리하는 속도의 차이를 해결하기 위한 것이다.
만약, 둘의 처리 속도가 차이나게 되면 수신자가 받은 데이터를 저장하는 버퍼가 가득 차 오버플로우가 발생하는 문제로 패킷이 계속해서 손실될 수 있다.
이를 해결하기 위해 송신자가 수신자가 현재 수신할 수 있는 데이터 크기를 알 수 있어야 하고, 이는 TCP 헤더의 `window size`에 값이 쓰인다. 흔히 `Recieve Window`라고 한다.

**혼잡 제어**는 데이터를 송수신하면서 사용하는 네트워크(라우터)의 혼잡한 상황으로 인해 발생하는 지속적인 패킷 유실을 막기 위한 것으로, 
`Slow start`와 `Fast Recovery` 방식이 있다. 둘 모두, 송신자의 데이터 전송 속도(전송량)을 조절하는 것이다.

마지막으로, 연결 지향성 프로토콜 TCP의 핵심인 연결 시작, 종료 방식에 대해 알아보자.

연결 시작의 경우, `3-way handshake` 방식을 사용하며, 연결 종료의 경우 `4-way handshake` 방식을 사용한다.

두 방식 모두 자세히 설명할 경우 길어지므로 정의만 설명하겠다.

`3-way handshake`는 TCP의 특징인 정확한 전송과 연결지향성을 위해, 연결 전에 데이터를 송수신하는 양쪽 클라이언트-서버가 연결 및 데이터 전송의 준비가 되어있음을 확인하는 과정이다.

`4-way handshake`는 연결되어 있던 양쪽 클라이언트-서버가 각각 연결을 종료하기 위해 수행하는 과정이다.

## UDP

UDP는 전송 계층에서 사용하는 프로토콜 중 하나로, `User Datagram Protocol`의 약자이다.
UDP의 헤더 구조를 먼저 살펴보자.

<img width="424" alt="UDP 헤더 구조" src="https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/a93b1eda-5e65-4ad4-b9ea-386268228311">

TCP 헤더와 달리 매우 간단하다. 필수적으로 써야 하는 건 총 4개로, 송신 포트 번호, 수신 포트 번호, 길이, checksum이다.

이와 같이, UDP는 단순히 (최소한의 무결성을 확인하면서) ‘전송’에만 초점을 맞추고 있는 걸 볼 수 있다. TCP랑은 달리 신뢰성도 없고, 데이터의 순서도 꼬일 수 있으며, 패킷이 유실되어도 신경쓰지 않는다.

그렇다면 UDP의 장점은 뭐길래 프로토콜이 존재하는가? 바로 속도이다. 필요한 헤더 데이터가 정말 적으므로 데이터 자체가 작고,  수신자의 응답을 확인하지 않아도 되므로 속도가 빠르다.
이런 UDP는 속도가 중요한 분야에서 사용한다.
- 미디어 스트리밍
- DNS
- SNMP(Simple Network Management Protocol)

UDP의 경우도, 어플리케이션 계층에서 신뢰성을 구현하여 지원할 수 있긴 하다.

## 시스템 콜

System Call은 Kernel에서 제공하는 Protected한 서비스를 이용하기 위해 필요한 것으로, User Mode에서 Kernel Mode로 진입하기 위한 ‘통로’의 역할을 한다.
System Call에는 다음과 같은 것들이 있다.

- Open
- Write
- Msgsnd
- Shm

이러한 System Call을 이용해, Kernel Mode에서 Privileged 명령어를 실행하거나, 레지스터에 접근하는 등의 기능을 이용할 수 있다.

## 하드웨어 인터럽트

Hardware Interrupt는 HW에서 발생하는 이벤트를 처리하는 기법 Interrupt, Trap 중 하나이다.
Hardware Interrupt는 Trap과 달리, 비동기적 이벤트를 처리하기 위한 기법이다.
ex) 네트워크 패킷 도착, I/O 요청 등

Interrupt의 처리 순서는 다음과 같다.

1. Interrupt Disable(타 인터럽트 방지)
2. 현재 실행 상태(State)를 저장
3. `ISR(Interrupt Service Routine)`으로 점프
4. 저장한 실행 상태(State)를 복원
5. 인터럽트로 중단된 지점부터 다시 시작

이러한 Hardware Interrupt에는 우선순위가 존재해, 처리 순서가 정해진다.

## 리눅스의 파일과 파일 디스크립터

리눅스에서, 정확히는 전반적인 UNIX 체제에서는 모든 것을 ‘file’로 규정한다.

윈도우에선 외부 장치를 이용할 때, 이에 대응하는 장치 드라이버가 있다. UNIX에서는 이 드라이버를 device node(device file)라고 하며, 이 node를 ‘open’하여 장치를 이용한다.

이러한 device node는 장치 뿐만 아니라 서비스(프로그램)에도 대응하고 있다.
예시로, `/dev/null`은 null한 device node이다. UNIX 체제에서 어떤 파일의 내용을 지우고자 할 때,
`cat /dev/null > {대상_파일명}`을 쓰는 방식으로 이용하는 것처럼, UNIX는 모든 것을 파일로, 심지어 Kernel 마저도 파일로 취급한다.

**File Descriptor**는 파일에 접근하고자 할 때 이용되는 것으로, 특정 프로세스에서 열려 있는 파일을 나타내는 작은 integer 값이다.
프로세스는 파일을 open하면 Kernel에서 해당 프로세스가 사용하지 않는 fd 중 가장 작은 값을 fd로 할당하여 리턴한다.

file의 경우, 각 프로세스마다 open한 file이 구분되며, 이렇게 open된 file에 대응하여 할당된 file descriptor는 각각의 프로세스가 관리하는 File Descriptor Table(FDT)에 저장된다.

기본적으로 프로세스가 실행될 때 0, 1, 2의 fd가 할당되는데, 이는 각각 다음 파일에 대응한다.

> **0: Standard Input** <br/>
> **1: Standard Output** <br/>
> **2: Standard Error**

## socket() 시스템 콜

socket() 함수는 communication을 위한 소켓(endpoint)을 생성 후, 이에 대응하는 file descriptor를 리턴하는 시스템 콜이다.

socket() 함수의 정의 및 파라미터의 역할은 다음과 같다.

```c
int socket(int domain, int type, int protocol);
// domain: 소켓이 사용할 프로토콜 체계(Protocol Family) 정보
// ex) AF_INET, AF_INET6, AF_LOCAL 등
// type: 소켓의 데이터 전송 방식(semantics)에 대한 정보. TCP/UDP/사용자 정의 4계층 통신
// ex) SOCK_STREAM, SOCK_DGRAM, SOCK_RAW 등
// 통신하는 컴퓨터 간에 사용되는 프로토콜 정보. 정수 값 0, 6, 17을 이용해 프로토콜 선택이 가능하다.
```


> `int protocol` 파라미터의 필요성 <br />
> 위 socket() 함수 파라미터를 보면 의아한 부분이 하나 있다. 이미 소켓이 사용할 프로토콜 체계인 `domain`과 데이터 전송 방식인 `type`을 이용했는데도 `protocol`을 한 번 더 입력해야 한다. 
> 만약, domain은 AF_INET, type은 SOCK_STREAM으로 설정했을 경우 IPv4 기반 연결 지향 소켓인 TCP 소켓이 생성될 거라고 쉽게 예측할 수 있다.
> 실제로도 그렇다. 그래서 값 `0`을 `protocol` 파라미터로 전달하여 원하는 소켓이 생성되도록 한다.
> <br />그렇다면 `protocol`의 필요성은 무엇인가? 이는 동일한 프로토콜 체계, 동일한 데이터 전송 타입임에도 **‘최종 통신 형태(프로토콜)’이 다른 경우에 사용하기 위한 인자**이다. 
> 즉, 프로토콜의 구체화를 위한 파라미터이다. 예시로, 사용자 정의 소켓을 생성하는 경우에 유용하게 사용될 수 있다.


## bind() 시스템 콜

bind() 함수는 소켓에 주소 정보를 할당하는 시스템 콜이다.
초기에 생성된 소켓은 address familly 공간이 존재하지만 아직 값이 할당되어 있지 않으므로, bind() 함수를 이용해 이를 할당한다.
bind() 함수의 정의 및 파라미터의 역할은 다음과 같다.

```c
int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
// sockfd: 주소를 할당할 소켓의 file descriptor
// addr: 소켓에 바인딩할 IP 주소 및 Port 번호를 담은 sockaddr 구조체
// addrlen: addr 파라미터에 전달된 아규먼트의 크기
```

bind() 함수의 리턴값은 성공 시 0, 에러 발생 시 -1이다.

2번째 파라미터인 addr의 타입인 `sockaddr *` 의 `sockaddr` 구조체는 다음과 같은 형태이다.

```c
struct sockaddr
{
  sa_family_t  sin_family;
  char         sa_data[14];
}
```

bind() 함수는 특정 프로토콜 체계의 소켓만 바인딩하는 것이 아닌, 일반적으로 사용할 수 있는 함수이므로 
sockaddr_in이나 sockaddr_un 구조체가 아닌, sockaddr 구조체로 파라미터를 전달받는다.

## listen() 시스템 콜

listen() 함수는 소켓을 ‘passive socket’으로 만드는 시스템 콜이다. ‘passive socket’은 들어오는 요청을 accept() 함수를 통해 수락하는데 사용되는 소켓을 의미한다.

즉, listen() 함수는 accept() 함수와 함께 서버에서 생성한 소켓을 요청을 받아들이는 소켓으로 만드는 데 쓰인다.

```c
int listen(int sockfd, int backlog);
// sockfd: passive socket으로 만들 소켓의 file descriptor
// backlog: 연결을 대기하는 요청을 담아둘 큐의 크기(대기열 최대 크기)
```

listen() 함수의 리턴값은 성공 시 0, 에러 발생 시 -1이다.

## accept() 시스템 콜

accept() 함수는 연결 대기 중인 요청 중 가장 첫 번재 연결 요청을 뽑아 기존 소켓의 상태를 상속하는 새 소켓을 만들어 file descriptor를 할당하는 시스템 콜이다.

accept() 시스템 호출은 보류 중인 연결 대기열의 첫 번째 연결 요청을 추출하고, 새 소켓을 만들고, 원래 소켓의 상태를 상속하는 소켓에 대한 새 파일 설명자를 할당합니다.

즉, listen() 함수는 accept() 함수와 함께 서버에서 생성한 소켓을 요청을 받아들이는 소켓으로 만드는 데 쓰인다.

```c
int accept(int sockfd, struct sockaddr *_Nullable restrict addr,
                  socklen_t *_Nullable restrict addrlen);
// sockfd: 요청을 받아들이는 passive socket의 file descriptor
// addr: 연결 주체(송신자)의 주소 정보
// addrlen: addr(송신자 주소 정보)의 구조체 크기
```

accept() 함수는 실행 성공 시 **accept한 socket에 대한 fd를 생성하여 리턴**하고, 에러 발생 시 -1을 리턴한다.

## 멀티 프로세스

멀티 프로세스는 2개 이상의 프로세스가 동시에 실행되는 것을 말한다.

여기서 동시란 **동시성(Concurrency)**과 **병렬성(Parallelism)**을 의미하는데, 동시성은 짧은 시간 동안 여러 프로세스가 번갈아 가며 실행되는 것을, 
병렬성은 실제로 여러 CPU(코어)를 이용해 여러 프로세스가 동시에 실행되는 것을 뜻한다.

하나의 CPU에서 여러 프로세스가 번갈아 가며 실행되기 위해선, 기존에 실행되던 프로세스(old process)의 상태를 저장 후, 
새로운 프로세스에 대한 정보들을 로드해오는 과정인 **Context Switch**가 필요하다. 
이 Context Switch 중에는 해당 작업만 가능하므로 **오버헤드**에 해당한다.

## 병렬 처리

**병렬 처리는 여러 개의 작업을 동시에 실행하여서 효율을 높이는 것**을 의미한다. 앞서 배운 서버 소켓이 listen 중일 때 클라이언트의 
connect()로 인해 연결 요청이 들어오면, 이에 대응하는 accept() 실행 후 나머지 응답 작업을 실행하기 위한 자식 프로세스를 생성하여 
역할을 분담하여 동시에 실행하는 것이 병렬 처리의 예시이자 멀티 프로세스 방식의 병렬 처리이다.

동시 실행이므로 멀티 프로세스 뿐만 아니라 멀티 스레드 방식을 이용할 수도 있다.

병렬 처리를 이용하면 직렬 처리에서 발생하는 병목 현상을 해소할 수 있다는 장점이 있다. 하지만, 병렬 처리를 이용해 처리한 데이터를 합치는 
합류점(직렬화 구간)이 존재한다면 이는 결국 또 하나의 병목 지점이 될 수 있다는 걸 인지하여, trade-off 관계를 따져 방식을 결정해야 한다.

병렬 처리의 예시는 다음과 같은 것들이 있다.

- 웹 서버: 다수의 이용자가 접속하는 웹 서버는 복수의 프로세스가 분담하여 요청을 처리한다.
- DB 서버: Oracle DB에서는 클라이언트 요청을 접수하는 서버 프로세스가 클라이언트 접속 수만큼 생성되는 멀티 프로세스 모델을 적용한다.