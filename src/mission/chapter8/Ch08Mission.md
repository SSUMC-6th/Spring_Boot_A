`ErrorCode` 인터페이스 추상화 후, 도메인별 분리된 `XXXErrorCode` 클래스를 생성하여 `ErrorCode`를 implement하도록 구조 설계

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/51f72008-8844-426f-946a-2b175f5ae4d4)

`ErrorCode`를 implement하는 `GlobalErrorcode`

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/c274ee5f-45a2-414a-86d2-ce3b9e5c2ce2)

`ResponseEntityExceptionHandler` 추상 클래스를 상속함으로써, Spring MVC 내부의 예외도 처리할 수 있도록 설정. `@RestControllerAdvice` 어노테이션을 통해 프로젝트의 모든 컨트롤러 내부에서 발생하는 예외에 대한 전역적인 처리를 수행하도록 하고, 내부에 설정된 `@ResponseBody`를 통해응답을 JSON으로 매핑하도록 설정.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/87c48dbc-153c-4921-a8f9-a10a40aca8c0)

input이 1인 경우 `200 OK` 응답

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/3084da49-04a7-4211-8809-1d479cec01c0)

input이 0인 경우 `400 BAD REQUEST` 응답

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/0e2c36fb-6f94-418d-8acd-7db7a08bc23e)
> **github 링크**
>
>
> https://github.com/bflykky/umc-workbook/tree/week6
>