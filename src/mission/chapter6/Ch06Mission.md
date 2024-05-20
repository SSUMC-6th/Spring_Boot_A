- 홈화면 (미션달성 개수, My mission)
    - 미션 달성 개수
        - API Endpoint: GET /users/{user-id}/missions/completed-count
    - My mission
        - API Endpoint: GET /users/{user-id}/missions/
        - Query String: ?status=in_progress&status=null&location=1
    - Request header: `Authorization : accessToken (String)`


- 마이페이지 리뷰 작성
    - API Endpoint: POST /users/{user-id}/my-page/reviews
    - Request header: `Authorization : accessToken (String)`
    - Request body

        ```json
        {
        	"store_id" : 24, 
        	"body" : "강력추천합니다!",
        	"score" : 4.5
        }
        ```

- 미션 목록 조회 (진행중, 진행 완료)
    - API Endpoint: GET /users/{user-id}/missions
    - Query string: ?status=in_progress&status=completed
    - Request header: `Authorization : accessToken (String)`


- 미션 성공 누르기
    - API Endpoint: PATCH /users/{user-id}/missions/{mission-id}
    - Request header: `Authorization : accessToken (String)`
    - Request body

        ```json
        {
        	"status" : "completed"
        }
        ```

- 회원가입 하기
    - API Endpoint:
        - POST /users/sign-up/agree
        - POST /users/sign-up/info
        - POST /users/sign-up/preference
    - Request body

        ```json
        {
          "age_agreement": true,
          "service_agreement": true,
          "privacy_agreement": true,
          "location_agreement": true,
          "marketing_agreement": true
        }
        ```

        ```json
        {
        	"name" : "최수빈",
        	"gender" : 1,
        	"birthday" : "2002-07-19",
        	"address" : "동작구"
        }
        ```

        ```json
        {
          "preference": {
            "foodtype": ["한식", "일식"]
          }
        }
        ```