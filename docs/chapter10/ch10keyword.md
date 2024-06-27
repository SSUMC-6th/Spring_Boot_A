# keyword 1-1 : Page

> 리뷰 글을 특정 조건으로 뽑아서 정렬 기준을 선택하여 조회하는 기능을 구현하고자 한다.
전체 리뷰글을 조회하거나, 내가 좋아요를 누른 리뷰글만 조회하거나, 내가 쓴 리뷰글만 조회하거나, 원하는 카테고리의 글만 조회하고 싶다면? → **Spring Data JPA**를 사용하여 구현할 수 있다!
게시글을 조회할 때 정렬 기준(최신순, 좋아요순)과 정렬방식(오름차순, 내림차순)을 선택하여 조회를 하고 싶다면? → **페이지네이션**을 사용하면 쉽게 구현할 수 있다!
> 

### 페이지네이션

사용자가 요청했을 때 데이터베이스에 있는 수천, 수만, 수백만 줄의 데이터를 모두 한번에 조회하여 제공한다면 서버의 부하가 굉장히 클 것이다.

- 이를 방지하기 위해서 대부분의 서비스에서는 데이터를 일정 길이로 잘라 그 일부분만을 사용자에게 제공하는 방식을 사용한다.
- 사용자는 현재 보고 있는 데이터의 다음, 이전 구간 혹은 특정 구간의 데이터를 요청하고, 전달한 구간에 해당하는 데이터를 제공받는다.

이 기능을 pagination (혹은 paging) 이라고 한다. Pagination은 아주 많은 상황에서 자주 사용되는데, 대표적인 예로는 게시판 목록이 있다.

### Spring Data JPA의 Pagination

---

DB 마다 pagination을 위해 사용되는 쿼리는 다 다르고, 난이도도 천차만별이다.

예를 들어, MySQL에서는 `offset` , `limit` 으로 상대적으로 간단히 처리가 가능하지만, Oracle의 경우 상당히 복잡하다.

JPA는 이런 여러 DB 별 방언(dialect)을 추상화하여 하나의 방법으로 페이지네이션을 구현할 수 있도록 제공해준다.

하지만, JPA로 페이지네이션 기능을 구현하는 작업은 생각보다 까다롭다.

- 전체 데이터 개수를 가져와서 전체 페이지를 계산해야하고, 현재 페이지가 첫번째 페이지인지, 마지막 페이지인지도 계산해야하고, 예상치 못한 페이지 범위를 요청받았을 때 예외처리도 해야한다.
- 물론, JPA 없이 DB에 직접 쿼리하는 방식보다는 훨씬 편리하지만, 여전히 신경써야 할 부분들이 많이 보인다.

Spring Data JPA는 이런 pagination도 추상화되어 있다. 각 페이지의 설정만 조정하여 전달하면 DB에서 해당 설정에 맞는 부분의 데이터만 조회할 수 있다.

### Pagable & PageRequest

Spring Data JPA로 pagination을 사용하기에 앞서, `Pagable` 에 대해서 알아보자.

- Pageable 은 Spring Data에서 제공하는 pagination 정보를 담기 위한 인터페이스이다
- 페이지 번호와 단일 페이지의 개수를 담을 수 있다. 이 Pagable을 구현하기 위해 `PageRequest` 라는 구현체도 제공한다.

### Pageable 생성

아래와 같이 `PageRequest` 의 static method를 이용하여 `Pageable` 을 구현할 수 있다.

```java
Pageable pageable = PageRequest.of(PAGE, SIZE);
```

- 여기서 PAGE 는 페이지의 순서 (index) 이고, SIZE 는 현재 페이지의 크기를 뜻한다.
- 참고: **page의 순서는 0부터 시작한다.**

### Pageable 정렬

아래와 같이 조회된 페이지를 어떤 방식으로 정렬할지 설정도 가능하다.

```java
PageRequest.of(PAGE, SIZE, Sort.Direction.ASC, "id"); // id 기준 오름차순
PageRequest.of(PAGE, SIZE, Sort.Direction.DESC, "id"); // id 기준 내림차순
```

이렇게 구현된 `Pageable` 을 아래와 같이 Spring Data JPA repository에 전달하면 된다.

```java
public interface ImageRepository extends JpaRepository<Image, Long> {

    Page<Image> findAllByOwnerId(Long ownerId, Pageable pageable);

}
```

```java
 Page<Image> savedImages = userService.findSavedImages(loginUser.id(), pageable)
```





# keyword 1-2 : Slice
### Page & Slice

> 코드를 보면, Spring Data JPA의 페이징 반환 값은 `Page` 라는 것을 확인할 수 있다. 이 `Page` 는 어떤 기능을 갖고 있는 것일까?
> 

- 사실, Spring Data JPA 레포지토리에 `Pageable` 을 전달하면, 반환 타입으로 위에서 나온 `Page` 와 `Slice` 를 받을 수 있다.
- 두 인터페이스 모두 pagination을 통한 조회 결과를 저장하는 역할을 한다.
- **참고로, Page 는 Slice 를 상속받는다.**

`Slice` 는 별도로 count 쿼리를 실행하지 않는다. 따라서 전체 페이지의 개수와 전체 엔티티의 개수를 알 수 없지만, 불필요한 count 쿼리로 인한 성능 낭비는 발생하지 않는다. 따라서, infinite scroll과 같이 전체 페이지 개수가 굳이 필요하지 않는 상황에 자주 사용된다.

반대로 `Page` 는 count 쿼리를 실행하여, 전체 데이터 개수와 전체 페이지 개수를 계산할 수 있다. 따라서, 우리가 흔히 볼 수 있는 게시판의 pagination UI 등을 구현할 때 적합하다.





# keyword 2 : 객체 그래프 탐색
### 객체 그래프 탐색

- 객체 A가 있을 때 **A가 참조하는 다른 객체 B, C, D 등을 A를 통해 참조하는 것**을 객체 그래프 탐색이라고 한다. (참조를 사용해서 연관관계를 탐색하는 것)
- SQL을 직접 다루면 SQL에 따라 객체 그래프를 어디까지 탐색할 수 있는지 정해진다.
    - 예를 들어 SQL이 B와 C까지만 조회하는 SQL이라면 B나 C까지만 참조할 수 있다. 이처럼 어디까지 객체 그래프 탐색이 가능한지 알아보려면  SQL을 직접 확인해야 한다. 그렇다고 A와 관련된 모든 객체를 조회해서 메모리에 올려두는 것은 현실성이 없다. 결국 A를 조회하는 여러 메소드를 만들어야 한다.

 

<aside>
💡  이때, JPA를 이용하면 객체 그래프를 마음껏 탐색할 수 있다. JPA는 연관된 객체를 사용하는 시점에 적절한 SELECT SQL을 실행하기 때문이다. 이 기능은 **실제 객체를 사용하는 시점까지 데이터베이스 조회를 미룬다고 해서 지연 로딩**이라 한다.

</aside>

A를 사용할 때마다 B를 함께 사용한다면 A를 조회하는 시점에 조인을 이용해서 B까지 함께 조회하는 것이 효과적이다. **JPA는 연관된 객체를 즉시 함께 조회할지 아니면 실제 사용되는 시점에 지연해서 조회할지를 간단한 설정으로 정의할 수 있다.**

### SQL을 직접 사용하면?

개발자가 객체지향 애플리케이션과 데이터베이스 중간에서 SQL과 JDBC API를 사용해서 변환 작업을 직접 해주어야 한다. 많은 시간과 비용이 드는 일이다. 개발의 중심이 객체가 아닌 데이터(SQL)로 이동하기 쉽다.

=> JPA를 이용하면 개발자는 데이터 중심인 관계형 데이터베이스를 사용해도 객체지향적으로 애플리케이션을 개발할 수 있다.

### ORM이란 무엇인가

객체와 관계형 데이터베이스 사이에 존재하는 패러다임 불일치를 해소해준다. 또한 지루하고 반복적인 CRUD SQL을 알아서 처리해줄 뿐만 아니라 객체 모델링도 손쉽게 할 수 있도록 도와준다. ORM을 통해 개발자는 더 중요한 일에 집중할 수 있다.

### JPA

JPA란 자바 진영에서 Hibernate를 기반으로 만든 ORM 표준이다.

출처 [https://velog.io/@zioo/ORM이란](https://velog.io/@zioo/ORM%EC%9D%B4%EB%9E%80)






# keyword 3 : JPQL
> `JPA`를 사용하여 서비스를 구현하다 보면 JPA의 `Query Methods`만으로는 조회가 불가능한 경우가 생깁니다!
> 
> 
> 예를들면 사용자 이름과 이메일로 조회하고 싶거나 나이가 20살 이상인 사용자를 조회하고싶거나 등등 이런 경우가 있을 수 있겠죠??
> 
> 이러한 경우 `JPQL(Java Persistence Query Language)`를 이용하여 SQL과 비슷한 형태의 쿼리를 작성하여 조회를 할 수 있습니다.
> 
> `@Query` Annotation과 `EntityManager.createQuery`등을 사용하여 JPQL를 작성하는 방법에 대해서 알아보겠습니다.
> 

### JPQL이란?

- Java Persistence Query Language
- 객체지향 쿼리로 JPA가 지원하는 다양한 쿼리 방법 중 하나
- `SQL` : 테이블을 대상으로 쿼리
    
    `JPQL` : 엔티티 객체를 대상으로 쿼리
    

### @Query?

- @Query는 더 구체적인 쿼리 메서드를 작성하기 위해 사용하는 쿼리 메서드의 custom버전
- `@Query` Annotation는 `Entity`의 `JpaRepository`를 상속받는 인터페이스에 정의합니다
    
    ```sql
    public interface UserRepository extends JpaRepository<User, Long> {
        @Query("쿼리문")
        List<User> methodName();
    ```
    

- 작성방법: `from` 구문에 `Entity`의 객체를 선언하여 해당 객체의 속성명을 통해서 조건과 파라미터를 작성
- 주의 : **각 문장에 끝에 띄어쓰기를 추가**
    - 각 문장이 문자열로 이어져있기 때문에 , 문자의 처음 또는 끝에 띄어쓰기가 없는 경우 한 문장으로 인식되어 정상적인 문장이 아니게 됩니다.

- 예시 : 아래와 같은 User 엔티티가 있을 때
    
    ```java
    @Entity
    @Getter
    @Setter
    @NoArgsConstructor
    @Table(name = "user")
    @AllArgsConstructor
    public class User {
        @Id
        private String id;
    
        private String name;
    
        private String phone;
    
        private String registerInfo;
    
        private String deptId;
    }
    ```
    
    이렇게 사용해줄 수 있다.
    
    ```java
    public interface UserRepository extends JpaRepository<User, String> {
    
        @Query(value = "select user " +
                "from User user " +
                "where user.name = :name")
        List<User> findByName(@Param("name") String name);
    ```
    

더해서,

우리가 많이 사용하는 function과 `join`을 사용하기 위해선 정의한 `Entity` 속성 이외에 속성이 추가 될 것이다

- 이를 위해 `DTO` 반환이 필요하다.
- @Query Annotation를 사용하여 DTO 반환을 하기위해서는
    
    **select 구분에서 생성자를 통해서 객체를 반환**하면 된다
    

- JOIN 예시: 이런 DTO가 있다면
    
    ```java
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public class UserDto {
    
        private String id;
    
        private String name;
    
        private String phone;
    
        private String deptId;
    
        private String deptName;
    }
    ```
    
- 이렇게 반환하기
    
    ```java
    public interface UserRepository extends JpaRepository<User, String> {
        @Query(value = "select max(user.id) " +
                "from User user " +
                "where user.deptId is not null")
        String findMaxUserId();
    }
    ```
    

- function을 사용한 예시
- JPQL에서는 기본적으로 `select`의 max, min, count, sum, avg를 제공하며 기본 function으로는 COALESCE, LOWER, UPPER등을 지원한다.
    
    ```java
    public interface UserRepository extends JpaRepository<User, String> {
        @Query(value = "select max(user.id) " +
                "from User user " +
                "where user.deptId is not null")
        String findMaxUserId();
    }
    ```
    
- 하지만 `JPQL`에서 지원하는 함수만으론 한계가 존재..!!

## EntityManager

EntityManager를 이용하여 NativeQuery를 작성하는 방법은 

`createNativeQuery()`를 통해서 SQL 문장을 작성하는 것

- EntityManager를 사용하는 경우 `Hibernate`의 `NativeQuery.class`를 이용하여 `setResultTransformer`를 통해 `DTO class`를 매핑하여 결과를 리턴받는다.

- 예시
    
    ```java
    public List<UserDto> test7(){
            return entityManager.createNativeQuery("select user.id as id, user.name as name, user.phone as phone, user.dept_id as deptId, dept.name as deptName " +
                    "from user user " +
                    "left outer join dept dept on user.dept_id = dept.id " +
                    "where match (user.name) against (:name in boolean mode) > 0").setParameter("name","le")
                    .unwrap(NativeQuery.class)
                    .setResultTransformer(Transformers.aliasToBean(UserDto.class))
                    .getResultList();
       }
    ```
    

---

이런 JPQL에는 쿼리를 String 형태로 작성하고 있다는 문제가 있다.

그러다보니 아래와 같은 문제가 발생한다.

> JPQL의 문제점
> 
> 1. JPQL은 `문자열(=String) 형태`이기 때문에 `개발자 의존적` 형태
> 
> 2. `Compile 단계`에서 Type-Check가 불가능
> 
> 3. `RunTime 단계`에서 오류 발견 가능 (장애 risk 상승)
> 

그래서 JPQL 보완을 위해 나온 →  `query DSL` 등장

---

### query DSL이란?

- 정적 타입을 이용해서 SQL, JPQL을 코드로 작성할 수 있도록 도와주는 오픈소스 빌더 API
- 어떻게 문자열 형태인 JPQL을 보완 했을까?
    
    바로 **쿼리에 대한 내용을 함수 형태로 제공**하여 보완했다!
    

- 예시 코드
    
    ```java
    @PersistenceContext
    EntityManager em;
    
    public List<Person> selectPersonByNm(String firstNm, String lastNm){
    	JPAQueryFactory jqf = new JPAQueryFactory(em);
    	QPerson person = QPerson.person;
    
    	List<Person> personList = jpf
    								.selectFrom(person)
    								.where(person.firstName.eq(firstNm)
    									.and(person.lastName.eq(lastNm))
    								.fetch();
    
    	return personList;
    }
    ```
    

- 단점: 코드 라인이 늘어남
- 장점:
    1. 문자가 아닌 코드로 작성
    2. Compile 단계에서 문법 오류를 확인 가능
    3. 코드 자동 완성 기능 활용 가능
    4. 동적 쿼리 구현 가능
    

출처 https://velog.io/@bo-ram-bo-ram/JPQL