깃허브 링크: https://github.com/h-ye-ryoung/umc-practice/tree/mission10


# mission 1 : 내가 작성한 리뷰 목록 API

validator
![alt text](./images/1.png)

레포지토리에 유저로 추가
![alt text](./images/2.png)

서비스에서 유저id로 리뷰 찾기
![alt text](./images/3.png)

파라미터로 UserId와 Page를 받아서 처리
page는 page-1로 설정
![alt text](./images/4.png)

가게1 스웨거
![alt text](./images/5.png)

성-공
![alt text](./images/6.png)

페이지가 음수일 때
![alt text](./images/7.png)



# mission 2 : 특정 가게의 미션 목록 API

미션 레포지토리에서 스토어에 따른 미션 findAll
![alt text](./images/8.png)

서비스에서 특정 StoreId에 부합하는 모든 미션을 찾는 로직 구현
![alt text](./images/9.png)

missionResponse DTO에 Builder 패턴으로 미션프리뷰와 그 리스트의 DTO 작성
![alt text](./images/10.png)

Converter 작성
![alt text](./images/11.png)

컨트롤러 작성
파라미터로 Store와 Page를 받을 때, @ExistsStores와 @CheckPage로 검증
![alt text](./images/12.png)

요청
![alt text](./images/13.png)

응답 성공
![alt text](./images/14.png)

페이지 넘버 잘못됐을때
![alt text](./images/15.png)



# mission 3 : 내가 진행중인 미션 목록 API

서비스 로직
![alt text](./images/16.png)

UserMission 레포지토리
![alt text](./images/17.png)

특정 유저가 진행중인 미션의 목록 (미션은 DB에 직접 넣었습니다)
![alt text](./images/18.png)

성공
![alt text](./images/19.png)

페이지 넘버가 음수일때
![alt text](./images/20.png)