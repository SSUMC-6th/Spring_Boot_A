# 📌 핵심 키워드 정리

## Bean

- 스프링 IoC 컨테이너에 의해 관리되는 재사용 가능한 소프트웨어 컴포넌트 ⇒ 스프링 컨테이너가 관리하는 자바 객체, 하나 이상의 Bean을 관리함
    - 빈은 인스턴스화된 객체를 의미하며, 스프링 컨테이너에 등록된 객체를 스프링 빈이라고 함
- Bean으로 등록됐을 때의 장점
    - 의존성 관리가 수월
    - 스프링 IoC 컨테이너에 등록된 Bean들은 싱글톤 형태
- 싱글톤: 기본 싱글톤 스코프. 하나의 Bean 정의에 대해서 Container 내에 단 하나의 객체만 존재

  ⇒ 스프링에 여러번 빈을 요청하더라도 매번 같은 객체를 돌려주는 것

    - 애플리케이션 컨텍스트가 싱글톤으로 빈을 관리하는 이유: 대규모 트래픽을 처리할 수 있도록 하기 위함

## Spring 의존성 주입(DI)

- 스프링 컨테이너에서 객체 Bean을 먼저 생성해두고 생성한 객체를 지정한 객체에 주입하는 방식
    - 어떤 객체가 사용하는 의존 객체를 직접 만들어 사용하는 것이 아니라, **생성자를 사용하여 주입 받아 사용하는 방법** (new 연산자를 이용해 객체 생성하는 것) → setter, 생성자를 이용해 외부에서 주입
    - 객체 자체가 코드 상에서 객체 생성에 관여하지 않아도 됨 → 객체 사이의 의존도를 낮출 수 있음.
    - 스프링 컨테이너에서 객체의 생명주기를 관리, 객체의 의존관계 관리
    - DI를 통해 유연하고 확장성이 뛰어난 코드 작성 가능
- 강한 결합
    - 객체 내부에서 다른 객체를 생성하는 것
    - A 클래스 내부에서 B라는 객체를 직접 생성하고 있다면, B객체를 C객체로 바꾸고 싶을 때 A 클래스도 수정해야함 → 강한 결합
- 느슨한 결합
    - 외부에서 생성된 객체를 인터페이스를 통해서 넘겨받는 것
    - 런타임시 의존 관계 결정됨 → 유연한 구조
- `@Autowired`**란?**
    - **Spring Framework**에서 의존성 주입을 수행하기 위해 사용되는 어노테이션
    - 주로 생성자, 필드, 세터 메서드에 적용되어 해당 위치에 자동으로 의존성 주입
    - 특징
        1. 자동 의존성 주입
            - `@Autowired`를 사용하면 **Spring**은 해당 타입에 맞는 **빈(Bean)**을 찾아 자동으로 의존성을 주입
        2. 타입 기반 매칭
            - `@Autowired`는 주입할 의존성을 찾을 때 타입을 기반으로 매칭
        3. 필수 의존성
            - 기본적으로 `@Autowired`로 주입되는 의존성은 필수적으로 존재해야함. 주입할 수 있는 빈이 없으면 예외 발생
        4. 다양한 위치에서 사용 가능
            - `@Autowired`는 생성자, 필드, 세터 메서드 등 다양한 위치에서 사용 가능
- 사용방식
    1. 필드 주입(Field injection)

        ```java
        @Service
        public class UserService {
        
            @Autowired
            private UserRepository userRepository;
            @Autowired
            private MemberService memberService;
        
        }
        ```

        - 클래스에 선언된 필드에 생성된 객체를 주입해주는 방식
        - 필드에 주입할때는 **어노테이션 사용**, 스프링에서 제공하는 `@Autowired` 어노테이션을 주입할 필드 위에 명시
    2. 수정자 주입(Setter Based Injection)

        ```java
        @Service
        public class UserService {
        
            private UserRepository userRepository;
            private MemberService memberService;
        
            @Autowired
            public void setUserRepository(UserRepository userRepository) {
                this.userRepository = userRepository;
            }
        
            @Autowired
            public void setMemberService(MemberService memberService) {
                this.memberService = memberService;
            }
        }
        ```

        - 필드 값을 변경하는 Setter를 통해 의존성 주입해주는 방식
        - 생성자 주입과 다르게 주입받는 객체가 변경될 가능성이 있는 경우에 사용
    3. 생성자 주입(Constructor Based Injection) → 스프링에서 권장하는 방식

        ```java
        @Service
        public class UserService {
        
            private UserRepository userRepository;
            private MemberService memberService;
        
            public UserService(UserRepository userRepository, MemberService memberService) {
                this.userRepository = userRepository;
                this.memberService = memberService;
            }
        
        }
        ```

        - 클래스의 생성자를 통해 의존성 주입하는 방식
        - 생성자 주입은 인스턴스가 생성될 때 1회 호출되는 것이 보장 ⇒ 주입받은 객체가 변하지 않거나, 반드시 객체의 주입이 필요한 경우에 강제하기 위해 사용
        - 생성자 주입 시 필드에 `final` 키워드 사용할 수 있음
        - 생성자가 1개만 있을 경우 `@Autowired` 생략해도 주입 가능
        - 특징
            - *클래스 내 생성자가 한개*
            - *주입받을 객체가 Bean으로 등록*
            - Lombok 라이브러리를 통해 더 간편하게 작성 가능
        - 생성자 주입을 사용해야 하는 이유
            1. 객체의 불변성 확보 (의존 관계의 변경이 필요한 상황 거의 없기 때문)
            2. 테스트 코드의 작성 (순수 자바 코드로 단위 테스트 작성을 위해)
            3. final 키워드 작성 및 Lombok과의 결합
                - 생성자 주입 사용 시 필드 객체에 `final` 키워드 사용 가능하기 때문에, 컴파일 시점에 누락된 의존성을 확인할 수 있음. (다른 주입 방법들은 객체 생성 이후 호출되므로 `final`키워드 사용 불가)
                - `final` 키워드 붙이면 Lombok과 결합되어 코드를 간결하게 작성 가능 (`@RequiredArgsConstructor` 이용)

                ```java
                @Service
                @RequiredArgsConstructor
                public class UserService {
                
                    private final UserRepository userRepository;
                    private final MemberService memberService;
                
                    public void register(String name) {
                        userRepository.add(name);
                    }
                
                }
                ```

            4. 스프링에 비침투적인 코드 작성
            5. 순환 참조 에러 방지 (서로 참조하는 경우 StackOverflow 에러)

## IoC 컨테이너 = DI 컨테이너 = 스프링 컨테이너 = (ApplicationContext)

- IoC: 제어의 역전, 메소드나 객체의 호출 작업이 외부에서 결정되는 것
- 애플리케이션 컴포넌트의 중앙 저장소
- Spring Application 내에서 자바 객체를 관리하는 공간
- 역할
    - 의존성 주입(DI, Dependency Injection)을 통하여 Application을 구성하는 빈(Bean)들의 생명주기(Life Cycle)을 개발자 대신 관리 ⇒ **객체 Bean의 생성, 소멸, 의존성 관리**
- 종류
    1. BeanFactory
        - IoC 컨테이너의 기본이 되는 인터페이스
        - Bean을 관리하는 역할을 하는 인터페이스
    2. **ApplicationContext**
        - 구조: BeanFactory(인터페이스, 최상위) ← ApplicationContext(인터페이스) ← ApplcationContext(구현체)
        - ApplicationContext를 통해 Bean(스프링 객체) 관리
        - BeanFactory를 상속하기 때문에 BeanFactory의 모든 기능을 포함하고 있으며 그 외의 부가 기능을 제공하기 때문에, 컨테이너를 사용할때는 ApplicationContext 사용이 권장됨

## RestControllerAdvice

- Spring에서 **전역적으로 예외를 처리**할 수 있는 어노테이션
- `@RestController` 가 붙은 대상에서 Exception이 발생하는 것을 감지하는 역할
    - `@ControllerAdvice`와 `@RestControllerAdvice` 가 있음
- 둘의 차이
    - `@RestControllerAdvice`는 `@ControllerAdvice`와`@ResponseBody`가 붙어 있어 **응답을 Json으로 내려줌**
- 장점
    - Controller에서 예외 직접 처리하지 않아도 됨 → 어노테이션이 선언된 클래스에서 해당 예외를 캐치하고 적절한 응답을 반환하기 때문에 전역적으로 예외처리 가능
    - 예외에 따라 다른 처리 로직을 적용할 수 있음 (커스텀한 응답 생성 가능 → 특정 예외에 따른 에러 응답과 HTTP 상태코드 정의 가능)
    - 공통적인 예외처리 로직을 재사용할 수 있음 (`@RestControllerAdvice` 가 선언된 클래스는 모든 컨트롤러에 적용되므로, 여러 컨트롤러에서 발생하는 동일한 예외에 대해 한 곳에서 처리 가능)
    - 무분별한 try-catch문이 없음
- 없을 경우 불편한 점
    - 코드 중복 발생
    - 오류메세지에 일관성이 없음
    - 응답 데이터 형식 제한
    - 예외처리 로직 관리가 어려움
- 사용법
    1. 에러코드 정의
        - 인터페이스로 추상화

        ```java
        public interface ErrorCode {
            String name();
            HttpStatus getHttpStatus();
            String getMessage();
        }
        ```

        - enum 클래스로 ErrorCode 구현

        ```java
        @Getter
        @RequiredArgsConstructor
        public enum CommonErrorCode implements ErrorCode{
            INVALID_PARAMETER(HttpStatus.BAD_REQUEST, "Invalid parameter..."),
            INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "Internal server error..."),
            ;
        
            private final HttpStatus httpStatus;
            private final String message;
        
        }
        
        @Getter
        @RequiredArgsConstructor
        public enum PostErrorCode implements ErrorCode{
        
            DUPLICATED_POST_REGISTER(HttpStatus.BAD_REQUEST, "Duplicated post register..."),
            ;
        
            private final HttpStatus httpStatus;
            private final String message;
        }
        ```

    2. 커스텀 예외 만들기
        - 발생한 예외를 처리할 예외클래스 (Exception Class) 추가 → RuntimeException을 상속받고 ErrorCode를 필드로 가지는 클래스

        ```java
        @Getter
        @RequiredArgsConstructor
        public class RestApiException extends RuntimeException {
        
            private final ErrorCode errorCode;
            
            public ResourceNotFoundException(ErrorCode errorCode) {
            super(errorCode.getMessage());
            this.errorCode = errorCode;
          }
        
          public ErrorCode getErrorCode() {
            return errorCode;
          }
        
        }
        ```

    3. `@RestControllerAdvice` 를 선언한 클래스 만들기
        - 이 클래스는 스프링 빈으로 등록되며, `@ExceptionHandler` 어노테이션을 사용해서 특정 예외에 대한 처리 로직을 정의할 수 있음

        ```java
        @RestControllerAdvice
        public class GlobalExceptionHandler {
          
          /*
          * Developer Custom Exception: 직접 정의한 RestApiException 에러 클래스에 대한 예외 처리
          */
          @ExceptionHandler(RestApiException.class)
          protected ResponseEntity<ErrorResponse> handleCustomException(RestApiException ex) {
          	GlobalErrorCode globalErrorCode = ex.getGlobalErrorCode();
          	return handleExceptionInternal(globalErrorCode);
          }
        
          // handleExceptionInternal() 메소드를 오버라이딩해 응답 커스터마이징
          private ResponseEntity<ErrorResponse> handleExceptionInternal(GlobalErrorCode errorCode) {
            return ResponseEntity
              .status(errorCode.getHttpStatus().value())
              .body(new ErrorResponse(errorCode));
          }
       }
        
        ```

    4. Controller나 Service에서 커스텀 예외 발생시키기
        - Controller나 Service에서 비즈니스 로직을 수행하다가 예외 상황 발생 시 적절한 커스텀 예외를 throw함

        ```java
        @RestController
        @RequestMapping("/users")
        public class UserController {
        
          @Autowired
          UserService userService;
        
          @GetMapping("/{id}")
          public UserDto getUser(@PathVariable Long id) {
            User user = userService.findById(id);
            if (user.isActive()) {
              return UserDto.of(user);
            } else {
              throw new InactiveUserException(UserErrorCode.INACTIVE_USER);
            }
          }
        }
        ```


## Lombok

- 어노테이션 기반으로 코드를 자동완성 해주는 라이브러리
- Lombok을 이용하면 Getter, Setter, Equals, ToString 등과 다양한 방면의 코드 자동완성 시킬 수 있음 → `@Getter` , `@Setter` 등…
- 장점
    - 어노테이션 기반의 코드 자동 생성을 통한 생산성 향상
    - 반복되는 코드 다이어트를 통한 가독성 및 유지보수성 향상
    - Getter, Setter 외에 빌더 패턴이나 로그 생성 등 다양한 방면으로 활용 가능
- 기능 및 사용 예제
    - `@Getter @Setter`
        - 클래스 이름 위에 적용시키면 모든 변수들에 적용이 가능하고, 변수 이름 위에 적용시키면 해당 변수들만 적용 가능

        ```java
        @Getter
        public class Store extends Common {
        
            @Setter
            private String companyName;               // 상호명
            private String industryTypeCode;          // 업종코드
            private String businessCodeName;          // 업태명
         
         }
        ```

      모든 변수에 대해 Getter를 사용할 수 있지만, Setter의 경우 companyName에 대해서만 생기게 된다.

    - `@AllArgsConstructor`
        - 모든 변수를 사용하는 생성자를 자동완성 시켜주는 어노테이션
    - `@NoArgsConstructor`
        - 어떠한 변수도 사용하지 않는 기본 생성자를 자동완성 시켜주는 어노테이션
    - `@RequiredArgsConstructor`
        - 특정 변수만을 활용하는 생성자를 자동완성 시켜주는 어노테이션
        - final 혹은 @NonNull인 필드 값만 파라미터로 받는 생성자를 생성

        ```java
        @Getter
        @RequiredArgsConstructor
        public class Store extends Common {
        
            @NonNull
            private String companyName;                 // 상호명
            private final String industryTypeCode;     // 업종코드
            private String businessCodeName;          // 업태명
            
        
           
        	 /* RequiredArgsConstructor 통해 아래의 생성자를 자동 생성할 수 있다.
            public Store(String companyName, String industryTypeCode) {
                this.companyName = companyName;
                this.industryTypeCode = industryTypeCode;
            }
        	*/
        
        }
        ```

    - `@EqualsAndHashCode`
        - 클래스에 대한 equals 함수와 hashCode 함수를 자동으로 생성

        ```java
        @EqualsAndHashCode(of = {"companyName", "industryTypeCode"}, callSuper = false))
        // companyName과 industryTypeCode가 동일하다면 같은 객체로 인식
        // 상속하고 있는 경우, 상위클래스의 경우 적용시키지 않기 위해 callSuper=False
        
        // "companyName과 industryTypeCode가 같기 때문에 true가 나옴
        log.debug(store1.equals(store2));
                
         // "companyName과 industryTypeCode가 다르기 때문에 false가 나옴
         log.debug(store1.equals(store3));
      
        ```

    - `@ToString`
        - 클래스의 변수들을 기반으로 ToString 메소드를 자동으로 완성
        - 출력을 원하지 않는 변수에 @ToString.Exclude 어노테이션을 붙여주면 출력을 제외할 수 있음상위 클래스에 대해도 toString을 적용시키고자 한다면 상위 클래스에 @ToString(callSuper = true) 를 적용시키면 됨
    - `@Data`
        - @Data 어노테이션을 활용하면 @ToString, @EqualsAndHashCode, @Getter, @Setter, @RequiredArgsConstructor이  자동완성 됨 → 너무 무겁기 때문에 활용 지양
    - `@Builder`
        - 해당 클래스의 객체의 생성에 Builder패턴을 적용
        - 모든 변수들에 대해 build하기를 원한다면 클래스 위에 @Builder를 붙이면 되지만, 특정 변수만을 build하기 원한다면 생성자를 작성하고 그 위에 @Builder 어노테이션 붙이면 됨

        ```java
        @Builder
            public Store(String companyName, String industryTypeCode){
                this.companyName = companyName;
                this.industryTypeCode = industryTypeCode;
            }
            
        
        // 다음과 같이 사용 가능
        
        @GetMapping(value = "/init")
            private ResponseEntity init(){
                Store store = Store.builder()
                        .companyName("회사이름")
                        .industryTypeCode("업종코드")
                        .build();
        
                return ResponseEntity.ok(store);
            }
        ```

    - `@Delegate`
        - 한 객체의 메소드를 다른 객체로 위임

        ```java
        @NoArgsConstructor
        @Getter
        public class Member {
        
          private String name;
          private String email;
        
        }
        
        @Getter
        public class Report {
        
          @Delegate
          private List<Member> memberList;
        }
        
        public class Main {
        
          public static void main(String[] args) {
            Report report = new Report();
            
            /* add 메소드가 위임되어서 바로 호출이 가능 */
            report.add(new Member());
            // 기존 방식
            report.getMemberList().add(new Member());
            
          }
        }
        ```

    - `@Slf4j` , `@Log4j2` → 로깅 관련 롬복