# keyword1: java의 Exception 종류들
    
    ### **NullPointerException(NPE)**
    
    null 값을 가지고 있는 참조 변수로 객체 접근 연산자인 도트(.)를 사용했을때 
    
    ### **ArrayIndexOutOfBoundsException**
    
    배열에서 할당된 배열의 인덱스 범위를 초과해서 사용할 경우 발생하는 에러
    
    ### **NumberFormatException**
    
    Wrapper 클래스에서 parseXXX() 메소드들을 이용하여 문자열을 숫자로 변환할 때,
    
    숫자로 변환될 수 없는 문자가 오는 경우 발생하는 에러
    
    ### **ClassCastException**
    
    억지로 타입변환을 시도할 경우
    
# keyword2:  @Valid
    

    
    1. **@Valid**는 자바 표준 스펙이고 **@Validated**는 스프링에서 제공하는 어노테이션이다.
    2. **@Validated**를 통해 그룹 유효성 검사나 Controller가 아닌 다른 계층에서유효성 검증 가능
    3. **@Valid**는 **MethodArgumentNotValidException** 예외를
        
        **@Validated는 ConstraintViolationException** 예외를 발생시킨다.
        
    

- Valid 어노테이션은 주로 request body를 검증하는데 많이 사용 (유효성 검증)
- [**JSR-303(Bean Validation)**] 표준 스펙으로서 제약조건이 있는 객체에게 Bean Validation 을 이용해 조건을 검증하는 어노테이션

예시

UserRequest.java

```sql
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserRequest {
    @Email(message = "이메일 형식이 맞지 않습니다.")
    @NotBlank(message = "이메일을 입력해주세요.")
    private String email;

    @NotBlank(message = "이름을 입력해주세요.")
    @Size(min = 2 , max = 10 , message = "이름은 2자 이상 , 5자 이하여야 합니다.")
    private String name;

    @NotBlank(message = "나이를 입력해주세요.")
    @Size(min = 20 , max = 100 , message = "나이는 20~100세 사이의 사용자만 가입이 가능합니다.")
    private int age;
}
```

- **@Email:** Email 형식인지 확인
- **@NotBlank:** null , 공백을 허용하지 않음
- **@Size:** 길이를 제한할때 사용(min: 최소 , max: 최대)
- **@max:** 지정한 값 이하인지
- **@min:** 지정한 값 이상인지

UserController.java

```sql
@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
    private final UserService userService;

    @PostMapping(value = "")
    public ResponseEntity<UserDTO> create(@Valid UserRequest userRequest) {

        return new ResponseEntity<>(HttpStatus.CREATED);
    }
```

- @valid 선언

@valide를 확인해보기 위한 테스트 코드

```sql
@Test
@DisplayName("Valid 조건에 맞지 않는 파라미터를 넘기면 실패해야 한다")
void validTest() throws Exception {
    // given
    UserRequest userRequest = UserRequest.builder()
            .email("drogba02")
            .name("woobeen")
            .age(29)
            .build();

    // then
    mockMvc.perform(get("/user")
            .param("email" , userRequest.getEmail())
            .param("name" , userRequest.getName())
            .param("age" , Integer.toString(userRequest.getAge())))
            .andExpect(status().isCreated());
}
```

- 이메일 값이 형식에 맞지 않으므로 실패 !