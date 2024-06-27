# 4주차 키워드 정리

---

## 영속성 컨텍스트
영속성 컨텍스트(Persistence Context)는 “엔티티를 영구 저장하는 환경”을 의미한다. 이는 논리적인 개념이다.
<br />JPA에선 엔티티 매니저(EntityManager)를 통해서 영속성 컨텍스트에 접근하는 방식이다. 이때 언급하는 엔티티의 생명 주기(lifecycle)은 다음과 같다.

**엔티티의 생명 주기**
1. 비영속(new/transient)
   영속성 컨텍스트와 전혀 관계가 없는, 새로운 상태
2. 영속(managed)
   영속성 컨텍스트에게 관리되는 상태
3. 준영속(detached)
   영속성 컨텍스트에 저장되었다가 분리된 상태
4. 삭제(removed)
   삭제된 상태

영속성 컨텍스트를 이용할 경우, 다음과 같은 기능(이점)을 활용할 수 있다.

- **1차 캐시**
  영속성 컨텍스트 내에 ‘1차 캐시’가 존재하여, 엔티티를 조회할 때는 쿼리 실행 이전에 1차 캐시를 먼저 조회한다. 
  또한, 엔티티 등록 시 해당 엔티티의 (PK, 엔티티 클래스 객체) 쌍이 1차 캐시에 저장된다.
- **영속 엔티티의 동일성 보장**
  영속된 엔티티를 여러 번 조회할 경우, 해당 객체들이 모두 같은 객체라는 것을 보장한다.
  더 어려운 말로 하면, 1차 캐시로 반복 가능한 읽기(REPEATABLE READ) 등급의 트랜잭션 격리 수준을
  데이터베이스가 아닌 어플리케이션 차원에서 제공한다.
- **트랜잭션을 지원하는 쓰기 지연(transactional write-behind)**
  엔티티 등록(변경) 시, 해당 사항에 대한 쿼리를 생성하여 이를 ‘쓰기 지연 SQL 저장소’에 저장한다.
  이렇게 저장된 쿼리들은 트랜잭션 커밋 시 flush()로 인해 모두 실행된다.
  해당 이점으로 인해 버퍼링(배치 사이즈 설정)을 사용하여 성능을 향상시킬 수 있다.
- **변경 감지(Dirty Checking)**
  영속성 컨텍스트의 1차 캐시는 스냅샷도 저장한다. 스냅샷은, 처음 엔티티가 1차 캐시에 등록되었을 시점의 
  상태를 저장해놓 것을 의미한다. 만약, 엔티티를 수정한 경우 트랜잭션 커밋 시 flush()가 호출되는데, 
  이때 1차 캐시의 스냅샷과 현재 엔티티를 비교하여 변경 사항이 있는 경우 UPDATE 쿼리를 생성하여 
  쓰기 지연 SQL 저장소에 등록 후, 이를 실행해 DB에 반영한 다음 커밋한다.

## 양방향 매핑
양방향 매핑은, 데이터베이스에서 Foreign Key를 통해 각 테이블이 양방향의 연관관계를 가지는 것과 달리, 객체는 이와 같은 방식이 불가능하다.
<br />JPA에서 이를 대신하는 것이 양방향 매핑이다.

양방향 매핑은 연관된 2개의 객체가 서로 조회할 수 있도록 하기 위한 방법이다. 2개의 객체 중 한 객체를 연관관계의 주인으로 
지정 후, 그 객체에 외래 키에 대응하는 필드를 작성 후, 나머지 객체에도 `mappedBy` 속성을 통해 반대편 객체를 참조하는 
필드를 생성함으로써 매핑을 완료할 수 있다.

## N + 1 문제
**N + 1 문제**는 JPQL, JpaRepository 등을 이용해 쿼리를 실행할 경우, 해당 결과의 엔티티 객체가 필드로 가지고 있는 연관관계(엔티티) 또한 조회함으로써 추가적인 N번의 쿼리가 발생하는 문제를 뜻한다.

```java
// Order 엔티티 클래스가 Member 엔티티 클래스와 단방향 연관관계인 경우
// findAll() 로 order 테이블을 조회하는 1버의 쿼리가 수행되고, 결과로 n개의 order가 왔다.
// 연달아 연관된 Member를 찾기 위해 Member 테이블에 where order_id = {order_id}
// 조회 쿼리가 n번 추가로 수행된다.
List<Order> orderList = orderRepository.findAll();
```

이를 방지하기 위해 즉시 로딩(`FetchType.EAGER`) 대신 지연 로딩(`FetchType.LAZY`)를 사용하는 것이 좋다.
<br />단, 지연 로딩을 한다고 N+1 문제를 완전히 막을 수 있는 건 아니다.. 자세한 건 추가적인 공부가 필요하다.