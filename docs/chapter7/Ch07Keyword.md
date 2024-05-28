# 트랜잭션이란?

데이터베이스의 상태를 변화시키기 해서 수행하는 작업의 단위, 하나의 작업을 위해 더이상 분할될 수 없는 명령들의 모음

즉, 한꺼번에 **수행되어야 할 일련의 연산모음**

- select, insert, delete, update를 통해서 데이터베이스에 접근하는 것
- Commit이란 하나의 트랜잭션이 성공적으로 끝났고, 데이터베이스가 일관성있는 상태에 있을 때, 하나의 트랜잭션이 끝났다라는 것을 알려주기위해 사용하는 연산
- 이 연산을 사용하면 수행했던 트랜잭션이 로그에 저장되며, 후에 Rollback 연산을 수행했었던 트랜잭션단위로 하는것을 도와준다
- Rollback이란 하나의 트랜잭션 처리가 비정상적으로 종료되어 트랜잭션의 원자성이 깨진경우, 트랜잭션을 처음부터 다시 시작하거나, 트랜잭션의 부분적으로만 연산된 결과를 다시 취소시킨다.
- 후에 사용자가 트랜잭션 처리된 단위대로 Rollback을 진행할 수도 있다.

[[MYSQL] 📚 트랜잭션(Transaction) 개념 & 사용 💯 완벽 정리](https://inpa.tistory.com/entry/MYSQL-📚-트랜잭션Transaction-이란-💯-정리)

# 영속성 컨텍스트

*영속성: 오래도록 또는 영원히 계속되는 성질이나 능력

영속성 컨텍스트란 `엔티티를 영구 저장하는 환경`

애플리케이션과 DB 사이에서 영구적으로 저장될 객체를 보관하는 가상의 DB 역할 (Entity를 보관하는 가상의 DB)

`Entity` : JPA에서 Entity란 DB 테이블에 대응하는 하나의 클래스. Java에서 객체에 `@Entity` 어노테이션을 붙이면 특정 DB테이블과 연동이 되어 테이블의 row 하나가 객체와 맵핑, 객체 내부 변수들이 해당 row에 있는 column과 연결이 되도록 관리됨.

- 엔티티의 4가지 상태
    - 비영속(new/transient): 영속성 컨텍스트와 전혀 관계가 없는 새로운 상태
    - 영속(managed): 영속성 컨텍스트에 관리되는 상태

        ```java
        EntityManager.persist(member)
        ```

    - 준영속(detached): 영속성 컨텍스트에 저장되었다가 분리된 상태

        ```java
        EntityManager.detach(entity) : 엔티티를 준영속 상태로 만듬
        EntityManager.close() : 영속성 컨텍스트를 닫음
        EntityManager.clear() : 영속성 컨텍스트를 초기화
        ```

    - 삭제(removed): 삭제된 상태

        ```java
        EntityManager.remove(entity)
        ```

- 영속성 컨텍스트의 이점
    - 1차 캐시
    - 동일성(identity) 보장
    - 트랜잭션을 지원하는 쓰기 지연
      (transactional write-behind)
    - 변경 감지(Dirty Checking)
    - 지연 로딩(Lazy Loading)

# 양방향 매핑

엔티티를 양방향 연관관계로 설정하면 객체의 참조는 둘인데 외래 키는 하나 ⇒ 둘사이 차이 발생

⇒ JPA에서는 **두 객체 연관관계 중 하나를 정해서 테이블의 외래키를 관리해야 하는데 이것을 연관관계의 주인이라고 함**

- 연관관계의 주인만이 데이터베이스 연관관계와 매핑, 외래키를 관리(등록, 수정, 삭제)할 수 있음.
- 주인이 아닌 쪽은 읽기만 할 수 있음
- `mappedBy` 속성을 이용해 어느 것을 주인으로 정할지 결정한다.
    - 주인은 `mappedBy` 속성을 사용하지 않는다.
    - 주인이 아니면 mappedBy 속성을 사용해서 속성의 값으로 연관관계의 주인을 지정해야 한다.
      ![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/118423039/d42c2a97-85f7-4048-93fa-40d92dfd80d8)

    - **연관관계의 주인은 외래 키가 있는 곳 →** 회원테이블이 외래키 가지고 있으므로 Member.team이 주인이 됨
      ![image](https://github.com/SSUMC-6th/Spring_Boot_A/assets/118423039/b7ab8add-f49a-496b-82c6-d38e5580581a)

    - 주인이 아닌 Team.members에는 `mappedBy="team"` 속성을 사용해서 주인이 아님을 설정해야 한다. 여기서 `mappedBy`의 값으로 사용된 team은 연관관계의 주인인 Member 엔티티의 team 필드.


******💡 데이터베이스 테이블의 다대일, 일대다 관계에서는 항상 **다** 쪽이 외래 키를 가진다. 다 쪽인 `@ManyToOne`은 항상 연관관계의 주인이 되므로 `mappedBy`를 설정할 수 없다. 따라서 `@ManyToOne`에는 `mappedBy` 속성이 없다.******



# N + 1 문제

- 연관 관계에서 발생하는 이슈로 연관 관계가 설정된 엔티티를 조회할 경우에 조회된 데이터 갯수(n) 만큼 연관관계의 조회 쿼리가 추가로 발생하여 데이터를 읽어오게 됨. 즉, 1번의 쿼리를 날렸을 때 의도하지 않은 N번의 쿼리가 추가적으로 실행되는 것
- 언제 발생하는가
    - JPA Repository를 활용해 인터페이스 메소드를 호출할 때(Read 시)
- 누가 발생시키는가
    - 1:N 또는 N:1 관계를 가진 엔티티를 조회할 때 발생
- 어떤 상황에 발생되는가
    - JPA Fetch 전략이 EAGER 전략으로 데이터를 조회하는 경우
    - JPA Fetch 전략이 LAZY 전략으로 데이터를 가져온 이후에 연관 관계인 하위 엔티티를 다시 조회하는 경우
- 왜 발생하는가
    - JPA Repository로 find 시 실행하는 첫 쿼리에서 하위 엔티티까지 한 번에 가져오지 않고, 하위 엔티티를 사용할 때 추가로 조회하기 때문에.
    - JPQL은 기본적으로 글로벌 Fetch 전략을 무시하고 JPQL만 가지고 SQL을 생성

**EAGER(즉시 로딩)인 경우**

1. JPQL에서 만든 SQL을 통해 데이터를 조회
2. 이후 JPA에서 Fetch 전략을 가지고 해당 데이터의 연관 관계인 하위 엔티티들을 추가 조회
3. 2번 과정으로 N + 1 문제 발생

**LAZY(지연 로딩)인 경우**

1. JPQL에서 만든 SQL을 통해 데이터를 조회
2. JPA에서 Fetch 전략을 가지지만, 지연 로딩이기 때문에 추가 조회는 하지 않음
3. 하지만, 하위 엔티티를 가지고 작업하게 되면 추가 조회가 발생하기 때문에 결국 N + 1 문제 발생

- 예시 상황
    - 고양이 집사는 여러 마리의 고양이를 키우고 있다.
    - 고양이는 한 명의 집사에 종속되어 있다.


### 해결방법

1. Fetch join
    - N+1이 발생하는 이유: 한쪽 테이블만 조회하고 연결된 다른 테이블은 따로 조회하기 때문
    - 미리 두 테이블을 JOIN 하여 한 번에 모든 데이터를 가져올 수 있다면 N+1 문제 발생하지 않음

        ```java
        // JPQL로 작성
        @Query("select o from Owner o join fetch o.cats")
        List<Owner> findAllJoinFetch();
        ```

    1. @Entity Graph
        - JPQL을 사용하여 query문 작성하고 필요한 연관관계를 Entity Graph에 설정 → OUTER JOIN으로 실행된다.
        - @EntityGraph 의 attributePaths에 쿼리 수행시 바로 가져올 필드명을 지정하면 Lazy가 아닌 Eager 조회로 가져오게 된다.
    - 문제
        - 둘다 JPQL을 사용하여 JOIN문 호출 → 카테시안 곱이 발생하여 Owner의 수만큼 Cat 중복 데이터 존재 가능, 중복된 데이터가 컬렉션에 존재하지 않도록 주의해야 함.

          > **※ 카테시안 곱**
          >
          >
          > 두 테이블 사이에 유효 join 조건을 적지 않았을 때 해당 테이블에 대한 모든 데이터를 전부 결합하여 테이블에 존재하는 행 갯수를 곱한만큼의 결과 값이 반환되는 것
    
    - 해결방안
        - **J**PQL에 DISTINCT 를 추가하여 중복 데이터 조회하지 않기

            ```java
            @Query("select DISTINCT o from Owner o join fetch o.pets")
            List<Owner> findAllJoinFetch();
             
            @EntityGraph(attributePaths = {"pets"})
            @Query("select DISTINCT o from Owner o")
            List<Owner> findAllEntityGraph();
            ```

        - OneToMany 필드 타입을 Set으로 선언하여 중복 제거 (Set은 중복을 허용하지 않는 자료구조

            ```java
            @OneToMany(mappedBy = "owner", fetch = FetchType.EAGER)
            private Set<Pet> pets = new LinkedHashSet<>();
            ```