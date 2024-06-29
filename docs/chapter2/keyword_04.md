### 라우팅

- 데이터(패킷)가 전달되는 과정에서 여러 네트워크들을 통과해야 하는 경우,
    
    네트워크들의 연결을 담당하고 있는 라우터 장비가 데이터의 목적지가 어디인지 (IP주소) 
    
    확인하여 빠르고 정확한 길을 찾아 전달해주는 것 → 라우팅
    
- 패킷은 여러 라우터를 거쳐서 목적지 네트워크에 도착한다.
- `라우트` : 라우팅에 의한 경과

### 라우팅 테이블

- 가장 효율적이라고 판단되는 경로정보를 모아둔 테이블
- 라우터는 전달받은 패킷의 목적지 주소를 자신의 라우팅 테이블과 비교하여,
    
    어느 라우터에게 넘겨줄지 판단하게 됨
    
- 라우팅 프로토콜을 통해 라우팅 테이블을 구성
- `라우팅 프로토콜`: 라우터들끼리 경로 정보를 교환하는 프로토콜

### 정적 라우팅

- 관리자가 라우터마다 최적의 경로를 인위적으로 등록
- 판단을 관리자의 몫으로 남기므로 빠르고 안정적 (소규모 네트워크)

### 동적 라우팅

- 자동적인 라우팅 알고리즘에 의해 최적의 경로를 판단
- 라우터는 라우팅 프로토콜을 통해 변경된 네트워크에 대한 정보를 자동으로 교환
- → 라우팅 테이블을 라우터가 자동으로 작성

### IGP (Internal Gateway Protocol)

- 라우터로 상호 접속이 되어있는 여러 개의 네트워크 집합
    - 이 네트워크 집합 내에 존재하는 라우터는 도메인 내부 라우터가 되는데,
        
        이 안에서 이들끼리 라우팅 정보를 교환할 때 사용하는 라우팅 프로토콜 → `IGP`
        
    - RIP, IGRP, OSPF 등의 프로토콜이 있음
- `도메인` 혹은 `AS`(Automonous System)이라고 함
- 기업 내부에서의 라우팅 프로토콜은 IGP를 사용

### EGP (Exterior Gateway Protocol)

- 네트워크 집합을 몇 개의 그룹으로 나누었을 때,
    
    다른 그룹(다른 도메인)끼리 라우팅 정보를 교환하는 프로토콜 → `EGP`
    
    - EGP, BGP 등의 프로토콜이 있음
- 라우팅 도메인 간의 라우팅은 EGP를 사용
    - `라우팅 도메인` → 하나의 관리 정책 하에서 운영되어지는 라우팅 범위
    - 기업 및 ISP의 개별 네트워크가 그 단위가 됨