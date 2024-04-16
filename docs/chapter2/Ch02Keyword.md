# 2주차 키워드 정리

---

## AWS

![AWS에서 제공하는 수많은 기능들](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/b29d2dc3-3702-4907-9662-13fa6a05a049)

AWS에서 제공하는 수많은 기능들

**AWS**는 Amazon에서 제공하는, 현대에서 가장 널리 쓰이는 클라우드 컴퓨팅 서비스이다. 단순 EC2와 같은 컴퓨팅, S3 등의 데이터베이스, 스토리지와 더불어 
기계 학습 및 인공지능, 데이터 분석, 사물 인터넷 등의 기술도 제공하고 있다.

## 리전과 가용영역

**리전(Region)**은 AWS가 전세계적으로 데이터 센터를 클러스터링하는 물리적인 위치를 나타낸다. 하나의 리전은 지리적 영역 내에서 격리되고, 물리적으로도 분리되어 있는 최소 3개의 논리적 데이터 센터, AZ(Availability Zone, 가용 영역)로 구성된다.
하나의 리전 내의 AZ들은 독립적으로 전원, 냉각, 물리적 보안 등을 갖추고 있으며, 지연 시간이 매우 짧은  네트워크를 통해 연결되어 있어, 이를 통해 고가용성의, *fault-tolerance*한 어플리케이션을 설계할 수 있다.

**가용 영역(Availability Zone)**은 리전에 속해 있는 독립적인 전원, 네트워크, 연결성을 가진 1개 이상의 개별적인 데이터 센터이다. 위에서 설명한 것처럼 같은 리전 안의 가용 영역들은 지연 시간이 매우 짧은 네트워크로 연결되어 있어 높은 처리량과 낮은 대기시간을 제공한다. 가용 영역 간의 트래픽은 전부 암호화되어 있다.
가용 영역 간의 물리적 거리는 실제로 수 킬로미터 정도 떨어져 있다.

## 서브네팅

**서브네팅**은 효율적인 IP 주소의 사용을 위해 네트워크를 나누는 것을 의미한다. 기본적으로, IPv4 주소 체계에서 IPv4 주소는 5개의 클래스로 나뉜다.(Class A, B, … E) 이로 인해 주어진 IPv4 네트워크당 주소 수는 다음과 같다. (앞서 배운 서브네팅 시 주소 범위 계산 참고)

- Class A: 16,777,214
- Class B: 65,534
- Class C: 254

하고자 하는 말은, 이렇게 정해져 있는 ‘클래스’별로 나뉘어진 기준만으로는 주소를 요구하는 다양한 경우들을 모두 만족시킬 수 없다.
따라서, 각자가 원하는 만큼의 주소 범위를 가질 수 있도록, 네트워크를 더 작은 네트워크로 쪼개는 것이 **서브네팅**이다.

서브네팅 시 각 클래스별 기본 서브넷 마스크(Subnet Mask) 대신, 직접 서브넷 마스크를 정의하여 사용하면 되며, 이러한 서브넷 마스크를 
편리하게 표현하는 것이 `CIDR(Class Inter-Domain Routing)`이다.

`ex) 10.10.1.32/27`

## 라우팅

**라우팅(Routing)**은 패킷에 포함된 정보 등을 통해 목적지까지 해당 패킷을 전달하기 위해 네트워크에서 경로를 선택 및 변경하는 일련의 과정을 뜻한다.

## VPC
AWS에서 **VPC(Virtual Private Cloud)**는 사용자가 정의하는 논리적으로 독립된 하나의 가상 네트워크이다. 다시 말해, VPC는 AWS 내의 다른 가상 네트워크들과도 분리되어 있다. 해당 네트워크에서 사용자는 AWS의 리소스를 사용할 수 있게 된다.
VPC를 이용하면 클라우드 환경에서 다음과 같은 일들이 가능하다.

- VPC 내에서 인터넷으로부터의 접근을 허용하는 Public Subnet과, 제한된 접근만을 허용하는 Private Subnet을 모두 만들 수 있다.
- 어플리케이션 중 일부는 VPC 내 클라우드에서 실행하고, 일부는 On-Premise에서 실행할 수 있다.
- 여러 개의 VPC가 필요할 때, 여러 VPC를 생성 후 VPC 피어링을 통해 연결할 수 있다.

## 사설 IP주소

사설 IP 주소는 특정 네트워크 안에서만 사용하는 IP 주소를 뜻한다. 특정 네트워크에서만 사용하므로, 다른 네트워크에서 사용하는 사설 IP 주소와 중복되어도 문제가 되지 않는다. 즉, 부족한 IPv4 주소를 사용하는 데 부담이 적으며, 외부와의 통신 시 게이트웨이(공유기)의 공인 IP를 사용하게 되므로 보안성도 챙길 수 있다.

사설 IPv4 주소의 범위는 다음과 같이 정해져 있다.

- `10.0.0.0 – 10.255.255.255`
- `172.16.0.0 – 172.31.255.255`
- `192.168.0.0 – 192.168.255.255`

## 포트포워딩
포트 포워딩(Port Forwarding)은 특정 포트를 고정시켜 해당 포트와 내부 네트워크의 특정 호스트를 매핑한 후, 해당 포트로 데이터가 들어온 경우 
해당 데이터를 매핑시킨 호스트로 전달하는 방식을 의미한다. 따라서,  외부 네트워크가 자신이 통신하려는 호스트가 어떤 포트와 매핑되었는지만 알면, 
외부에서 내부 네트워크의 호스트와도 통신이 가능하다.

## NAT 프로토콜

![private 네트워크와 인터넷 간의 NAT](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/d5bff9ed-b1e5-441f-a18b-65b7d4d70ddb)

**NAT(Network Address Translation)**는 라우터를 통해 IP 주소, 포트 번호 등을 기록하면서 네트워크 패킷을 주고 받을 수 있게 
하는 프로토콜을 뜻한다. NAT는 주로 사설 IP를 사용하고 있는 호스트들을 위해 사용된다. 이 경우, 사설 IP 주소를 가진 호스트가 외부 네트워크와 
통신하고 싶을 때, 게이트웨이를 지날 때 NAT를 통해 자신이 패킷을 전달할 목적지 IP 주소, 포트 번호 등을 기록 후 게이트웨이의 공인 IP로 변경되어 
패킷이 나가게 된다. 물론, 이에 대한 수신 패킷이 게이트웨이를 지날 때도, 이전에 기록했던 정보와 지금 받은 수신 패킷을 비교하여 어떤 호스트에게 
전달해줘야 하는지를 파악할 수 있도록 하는 것이 NAT 프로토콜이다.

## 포트번호
**포트(Port)**는 운영체제 통신의 종단점(End-point)이다. 포트는 네트워크 서비스나 호스트 내에서 실행되고 있는 프로세스를 식별하기 위한 단위로, 
16비트로 이루어져 최대 65535까지 가능하다. 포트의 경우, 전송 계층(Transport Layer)의 TCP/UDP에서 사용한다.

포트의 범위는 크게 3종류이다.
- `0 ~ 1023`번: well-known port ⇒ 해당 범위의 경우, 특정 서비스들을 위해 사용되라고 예약되어 있는 포트 번호들이 많다. 
해당 범위의 포트 번호를 열기 위해선 `sudo` 권한이 필요하다.
- `1024 ~ 49151`번: registered port
- `49152 ~ 65535`번: dynamic port