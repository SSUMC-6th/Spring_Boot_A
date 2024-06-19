# java의 Exception 종류들

  ### 1. Checked Exception

  `Checked Exception`은 컴파일 타임에 처리되도록 강제되는 예외. 즉, 이러한 예외가 발생할 가능성이 있는 코드는 반드시 예외 처리를 해야 함.

  ### 주요 Checked Exception 종류:
### 

- **IOException**: 입출력 작업 중 발생하는 예외 (파일 읽거나 쓸때)
- **SQLException**: 데이터베이스 접근 작업 중 발생하는 예외
- **ClassNotFoundException**: JVM이 클래스를 찾지 못할 때 발생
- **FileNotFoundException**: 특정 파일이 존재하지 않을 때 발생
- **ParseException**: 문자열을 파싱할 때 오류가 발생하면 발생
- **InterruptedException**: 스레드가 대기, 슬립, 조인 상태에서 인터럽트될 때 발생

  ### 2. Unchecked Exception

  `Unchecked Exception`은 컴파일 타임에 강제되지 않으며, 런타임에 발생하는 예외. 이러한 예외는 프로그램의 논리적 오류로 인해 발생할 가능성이 높음

  ### 주요 Unchecked Exception 종류:

    - **RuntimeException**: 대부분의 언체크드 예외의 슈퍼 클래스
        - **NullPointerException**: 참조 변수가 null인 객체를 접근할 때 발생
        - **ArrayIndexOutOfBoundsException**: 배열의 잘못된 인덱스를 접근할 때 발생
        - **ArithmeticException**: 수학 연산에서 오류가 발생할 때 발생
        - **ClassCastException**: 객체를 잘못된 타입으로 캐스팅할 때 발생
        - **IllegalArgumentException**: 메소드에 부적절한 인자를 전달할 때 발생
        - **IllegalStateException**: 메소드가 부적절한 상태에서 호출될 때 발생
        - **NumberFormatException**: 문자열을 숫자로 변환할 때 형식이 잘못되면 발생

# @Valid


    - 빈 검증기(Bean Validator)를 이용해 객체의 제약 조건을 검증하도록 지시하는 어노테이션
- LocalValidatorFactoryBean가 제약 조건 검증을 처리함
- `@Valid`어노테이션은 주로 request body를 검증하는데 많이 사용
    - `NotNull, NotBlank` 등의 유효성 검사 어노테이션이 있음
  
    1. **메소드 매개변수 유효성 검사**: Spring MVC 컨트롤러에서 사용되어, HTTP 요청으로 전달된 객체의 유효성을 검사

        ```java
        
        @PostMapping("/users")
        public ResponseEntity<User> createUser(@Valid @RequestBody User user) {
            return ResponseEntity.ok(user);
        }
        
        ```

    2. **클래스 필드 유효성 검사**: 클래스 필드에 적용되어, 내부 객체의 유효성을 검사

        ```java
        
        public class Order {
            @Valid
            private List<@NotNull Item> items;
        }
        
        ```

    3. **중첩된 유효성 검사**: 객체 내의 객체 필드에 대한 유효성 검사

        ```java
        
        public class User {
            @Valid
            private Address address;
        }
        
        ```
### 유효성 검사 실패 처리

유효성 검사가 실패하면 `MethodArgumentNotValidException`이 발생하며, 이를 전역 예외 처리기로 처리 가능
```java
@RestControllerAdvice
public class GlobalExceptionHandler {
   @ExceptionHandler(MethodArgumentNotValidException.class)
   public ResponseEntity<Map<String, String>> handleValidationExceptions(MethodArgumentNotValidException ex) {
       Map<String, String> errors = new HashMap<>();
       ex.getBindingResult().getAllErrors().forEach((error) -> {
           String fieldName = ((FieldError) error).getField();
           String errorMessage = error.getDefaultMessage();
           errors.put(fieldName, errorMessage);
       });
       return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
   }
}
```