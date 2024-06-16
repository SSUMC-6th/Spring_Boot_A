# 9주차 키워드 정리

---

## java의 Exception 종류들

JAVA에서 예외(`Exception`)란, 프로그램이 수행되는 중에 프로그램의 정상적인 실행 흐름을 방해하는 이벤트를 뜻한다.

> Oracle Docs 원문: An *exception* is an event, which occurs during the execution of a program, 
> that disrupts the normal flow of the program's instructions.

실제 `Exception` 말고도 `Error`라는 것이 존재한다. `Error`는 프로그램의 실행이 중단될 정도로 심각한 문제를 뜻한다.
<br />반대로 말하면, `Exception`이 발생되어도 프로그램의 실행이 중단되지 않을 수 있다는 말이다. 이는 try -catch문 을 통해 구현할 수 있다.
<br />`Exception`의 계층 구조는 다음과 같다.

![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/67828333/6c5cae44-4e94-4968-812f-e180c3fe9094)

먼저, `Error`와 `Exception` 모두 `Throwable`을 상속함을 알 수 있다.

`Exception`을 상속하는 클래스들이 매우 많은데, 이 예외 클래스들은 두 분류로 나눌 수 있다. 위 그림을 참고하며 정의를 확인하자.

- Checked Exception: `RuntimeException`을 상속하지 않는 클래스
- Unchecked Exception: `RuntimeException`과, `RuntimeException`의 하위 클래스들

Checked Exception은 컴파일 시점에 check되는 예외 클래스들로, 반드시

1. 예외를 처리하는 try-catch문 코드 블록을 이용하거나
2. throws 키워드를 통해 예외를 던져야 한다.

위 방식을 이용하지 않을 경우 컴파일 에러가 발생한다.

ex) `IOException`

Unchecked Exception은 반대로 컴파일 시점에 명시적으로 check하지 않는 예외 클래스들로, 보통 런타임 시점에 발생한다. 이는 따로 try-catch문이나 throws 키워드를 이용하지 않아도 컴파일이 가능하다.

ex) `IllegalArgumentException`, `NullPointerException`

## @Valid

`@Valid` 어노테이션은 메소드 파라미터나 리턴 타입, 클래스 필드 등에 매핑되는 값을 검증하기 위해 사용하는 검증 어노테이션이다.  주로 요청 데이터가 백엔드 내에서 정해놓은 조건에 부합한지 확인하기 위해 사용한다.

보다 정확히는, `@Valid`는 “저거 유효한지 검증해!”라는 지시를 내리는 역할이며, 실제 검증을 하는 어노테이션은 별도로 있다.

ex) `@NotNull`, `@NotBlank`, `@Size`, `@Email`