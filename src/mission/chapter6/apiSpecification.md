# 6주차 미션 API 명세서 - 이단

> 해당 과제에서는 도메인과 화면 2개의 기준을 이용해 그룹화 하였지만, 실제로는 1개의 기준으로 구분하는 게 좋다.

## 사용자가 진행중이거나 진행 완료한 미션 목록 조회

---
URI: `/missions/my`

HTTP METHOD: `GET`

### 헤더
`Authorization`: 사용자임을 증명하는 JWT

### Path Variable
X

### Request Param
X

### Request Body Example
```json

```

### Response Body Example
```json
{
  "code": "String",
  "status": "number",
  "message": "String",
  "data": {
    "missions": [
      {
        "missionId": "Number",
        "content": , "String",
        "targetPrice": "Number",
        "reward": "Number",
        "test": ,
        "storeName": "String",
        "isSucceeded": "Boolean"
      },
      // ...
      {
        "missionId": "Number",
        "content": , "String",
        "targetPrice": "Number",
        "reward": "Number",
        "test": ,
        "storeName": "String",
        "isSucceeded": "Boolean"
      }
    ] 
  }
}
```

## 미션 성공 요청

---
URI: `/missions/{missionId}/complete`

HTTP METHOD: `POST`

### 헤더
`Authorization`: 사용자임을 증명하는 JWT

### Path Variable
`missionId`: 성공 요청을 하는 미션의 missionId, `Long` 타입

### Request Param
X

### Request Body Example
```json

```

### Response Body Example
```json
{
  "code": "String",
  "status": "number",
  "message": "String",
  "data": null
}
```


## 특정 지역에서 사용자가 완료한 미션 개수 조회

---
URI: `/missions/succeededMissionCount?region={regionId}`

HTTP METHOD: `GET`

### 헤더
`Authorization`: 사용자임을 증명하는 JWT

### Path Variable

### Request Param
`regionId`: 선택한 지역의 regionId, `Long` 타입

### Request Body Example
```json

```

### Response Body Example
```json
{
  "code": "String",
  "status": "number",
  "message": "String",
  "data": {
    "succeededMissionCount": "number"
  }
}
```

## 특정 지역에서 도전 가능한 미션 목록 조회

---
URI: `/missions?region={regionId}`

HTTP METHOD: `GET`

### 헤더
`Authorization`: 사용자임을 증명하는 JWT

### Path Variable

### Request Param
`regionId`: 선택한 지역의 regionId, `Long` 타입

### Request Body Example
```json

```

### Response Body Example
```json
{
  "code": "String",
  "status": "number",
  "message": "String",
  "data": {
    "missions": [
      {
        "missionId": "Number",
        "content": , "String",
        "targetPrice": "Number",
        "reward": "Number",
        "test": ,
        "storeName": "String",
        "isSucceeded": "Boolean"
      },
      // ...
      {
        "missionId": "Number",
        "content": , "String",
        "targetPrice": "Number",
        "reward": "Number",
        "test": ,
        "storeName": "String",
        "isSucceeded": "Boolean"
      }
    ] 
  }
}
```


## 새 리뷰 작성

---
URI: `/stores/{storeId}/reviews`

HTTP METHOD: `POST`

### 헤더
`Authorization`: 사용자임을 증명하는 JWT

### Path Variable
`storeId`: 리뷰 대상의 가게 storeId, `Long` 타입

### Request Param
X

### Request Body Example
```json
{
  "stars": "Number",
  "content": "String",
  "images": [
    "FileData",
    // ...
    "FileData"
  ]
}
```

### Response Body Example
```json
{
  "code": "String",
  "status": "number",
  "message": "String",
  "data": {
    "reviewId": "Number"
  }
}
```


## 회원가입

---
URI: `/auth/signup`

HTTP METHOD: `POST`

### 헤더
X

### Path Variable
X

### Request Param
X

### Request Body Example
```json
{
  "locationAgreement": "Boolean",
  "marketingAgreement": "Boolean",
  "name": "String",
  "gender": "String", // enum 형식으로 설정
  "birthDate": "Date", // 2024-05-20 형식
  "address": "String",
  "preferredFoodList": [1, 2, .., n] // foodId Array 형식
}
```

### Response Body Example
```json
{
  "code": "String",
  "status": "number",
  "message": "String",
  "data": {
    "memberId": "Number"
  }
}
```