# 3주차 미션 인증 - 이단

> 아래 요구사항 2, 3을 만족시키기 위해 default 파일을 수정 후, `sudo systemctl restart nginx`를 통해 nginx를 재시작하여 설정을 적용시켰다.


## 요구사항 1

‘idan-kimkangyeon’ 이라는 이름의 새로운 VPC 생성 후, ‘subnet-01’이라는 이름의 서브넷 생성, 이후 인터넷 게이트웨이와 라우팅 테이블 세팅을 통해 퍼블릿 서브넷 설정을 완료하였다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/e81b8c6d-0c32-4159-b73b-073c74c9951d)

그리고, 해당 VPC의 서브넷에 인스턴스 ‘umc-week3-mission-ec2’를 생성 후, 퍼블릭 IP를 할당 후 연결하였다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/6a0ecb90-94d2-474f-9ae2-25b7cec1696c)


이후 ssh 접속을 통해 Nginx 설치 후, `service nginx status` 명령어로 nginx가 잘 실행되고 있음을 확인하였다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/8e1be7b7-a766-495a-8811-8bf6ee8f7bab)


실제로 인스턴스의 public IP로 브라우저를 통해 접속 시, 아래와 같은 Nginx Welcome 화면을 볼 수 있었다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/39ecf0a9-9a8f-4982-a761-1cc15e447c1d)

## 요구사항 2

아래 `location /mission3` 블록을 통해 요구사항 2를 만족시켰다. index 설정을 통해 `/mission3` 경로로 요청 시 내 닉네임 이단과 함께 
인사하는 문자열을 가진 html을 정적 콘텐츠로 제공하도록 설정하였고, `/var/www` 경로에 `mission3` 디렉토리를 만든 후 해당 디렉토리에 `idan.html` 파일을 생성하였다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/39c61448-52cc-4f6d-8cd5-a0d5d2837f4e)

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/cfd49b9a-d951-4927-bde4-ad1c8fee42d4)

이후 nginx 재시작 후 테스트해보면 아래와 같은 결과가 나온다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/8179c8fe-baf4-4c17-aab2-dc69eea8de97)

## 요구사항 3

리버스 프록시 설정을 위해 `location` 블록과 `proxy_pass`를 이용하여 default 파일에 해당 코드를 추가하였다.
이때, 루트 경로 `/`가 아닌 `/was`이므로 root 설정을 통해 was 디렉토리를 잘 찾아갈 수 있도록 설정하였다. 이후, `was` 디렉토리도 `/var/www` 경로에 추가하여 404 에러가 나지 않도록 방지하였다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/77562726-4bd1-4ded-92d5-703ae63c83f7)

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/271f5edf-0ef0-400f-9d7f-37f56f4ab814)



이후 nginx 재시작 후 테스트해보면 아래와 같은 결과가 나온다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/4c745b04-2631-483b-b0b8-0440a5099f22)

