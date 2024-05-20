API Endpoint, Request Body, Request Header, query String, Path variable 포함

# 홈 화면
-----

### 사용자의 미션 달성 개수 가져오기
Endpoint: GET /users/{user_id}/missions/completion/count
Request Header: Authorization:accessToken(String)

### 특정 지역의 미션 리스트 가져오기 (사용자가 아직 도전 완료하지 않은)
Endpoint: GET /users/{user_id}/missions/availability
Query String: ?region_id
Request Header: Authorization:accessToken(String)



# 미션 목록 조회
---

### 진행 중
Endpoint: GET /users/{user_id}/missions/in-progress
Request Header: Authorization:accessToken(String)

### 진행 완료
Endpoint: GET /users/{user_id}/missions/completion
Request Header: Authorization:accessToken(String)



# 마이페이지 리뷰 작성
-----
Endpoint: POST /users/{user_id}/reviews
Request Header: Authorization:accessToken(String)
Request Body: 
{
  "store_id": "3",
  "score": "4"
  "body": "정말 맛있어요",
}


# 미션 성공 누르기
---
Endpoint: PATCH /users/{user_id}/missions/{mission_id}
Request Header: Authorization:accessToken(String)
Request Body: 
{
    "status": "completed"
}

# 회원 가입 하기
---

### 회원가입1
Endpoint: POST /users
Request Body: 
{
    "name": "김혜령",
    "gender": "female",
    "birth": "2002-08-29",
    "address_1": "서울특별시 동작구 상도동",
    "address_2": "정보과학관 5층",
}

### 회원가입2
Endpoint: POST /users/preferences
Request Body: 
{
    "preferences": [
    {
      "food_prefer_id": "number"
    }
  ]
}

### 약관 동의
Endpoint: POST /users/signup-agree
Request Body: 
{
    "all_agreed": "boolean",
    "agreements": [
        {
            "option_id": "number",
            "agreed": "boolean"
        }
    ]
}
> 옵션 개수는 배열로 유동적으로 처리
> 전체 동의가 true인 경우 agreements 배열은 빈 배열이 된다