# 10주차 키워드 정리

---

## Spring Data JPA의 Paging
**Spring Data JPA**
Spring Data JPA는 Spring 프레임워크의 하위 프로젝트인 Spring Data에 속하는 하나로, JPA를 더 쉽게 사용할 수 있게 해주는 도구이다.
<br />Spring Data JPA를 통해 다음과 같은 기능들을 이용할 수 있다.

- **Repository 인터페이스**
    - `CrudRepository`, `PagingAndSortingRepository`, `JpaRepository` 등 여러 기본 인터페이스를 제공함으로써 기본적인 CRUD 작업과 페이징, 정렬 기능을 쉽게 구현할 수 있다.
    - 개발자는 이러한 인터페이스를 확장하는 방식으로 repository 단을 작성할 수 있으며, 이를 통해 직접 SQL 쿼리를 작성할 필요 없이 데이터를 처리할 수 있다.
- **메소드 이름을 통한 쿼리 생성 (JPA Query Method)**
    - 메소드 이름을 통해 자동으로 쿼리를 생성하는 기능을 제공한다.
      예시로, `findByUsername(String username)`이라는 메서드를 정의하면, Spring Data JPA가 자동으로 `SELECT * FROM user WHERE username = ?`와 같은 쿼리를 생성한다.
- **JPQL 및 네이티브 쿼리 지원**
    - 복잡한 쿼리가 필요한 경우, `JPQL (Java Persistence Query Language)` 또는 네이티브 SQL 쿼리를 직접 작성할 수 있으며, 이를 통해 더 복잡한 데이터 접근 로직을 구현할 수 있다.
- **페이징 및 정렬**
    - 페이징과 정렬을 손쉽게 처리할 수 있는 기능을 제공한다. 메서드 파라미터로 `Pageable`이나 `Sort`를 전달하면, 자동으로 페이징 및 정렬된 결과를 반환한다.
- **Auditing**
    - 엔티티의 생성 및 수정 시점을 자동으로 기록하는 기능을 제공한다. 이를 이용해 엔티티의 생성일자와 수정일자를 손쉽게 관리할 수 있다.

---

이 중, 페이징의 경우 메소드 파라미터로 `Pageable` 인터페이스(또는 그 구현체)를 전달함으로써 간단하게 페이징 결과를 반환받을 수 있다.
<br />`Pageable` 인터페이스는 다음과 같은 정보를 가진다.

- 페이지 번호(page number)
- 페이지 크기(page size)
- 정렬 정보 (sort)

### Page
Spring Data JPA에 정의된 `Page` 인터페이스는 **페이징 처리된 결과**를 담고 있는 인터페이스이다.
<span style="color: green">⇒ 리턴값으로 쓰이는구나!</span>

이는 아래와 같은 정보를 포함한다.

- 현재 페이지의 데이터 리스트
- 총 페이지 수
- 총 요소 수
- 현재 페이지 번호
- 등등

### Slice
`Slice` 인터페이스의 경우 `Page`와 유사하지만, `Page`에서 제공하는 ‘전체 페이지 수’ 등의 정보는 제공하지 않으며, 대신 단순하게 다음 페이지가 있는지 여부를 제공한다.

## 객체 그래프 탐색
`객체 그래프 탐색(Object Graph Navigation)`은 JPA와 같은 ORM 프레임워크에서 데이터베이스의 관계형 데이터를 객체 모델로 변환하고 탐색하는 것을 의미한다.

쉽게 말하자면, Member 엔티티 클래스에서 Team 클래스를 참조하고 있는 상황에서, Member 객체를 통해 Team 객체에 접근하는 것이다.

⇒ 마치 ‘그래프 탐색’처럼, 하나의 엔티티 객체(정점)에서 출발해 다른 엔티티 클래스(정점)으로 이동하는 것이다.

## JPQL
`JPQL(Java Persistence Query Language)`은 JPA에서 사용하는 쿼리 언어이다. 이는 SQL처럼 RDBMS에서 데이터를 조회, 조작할 수 있게 한다.

JPQL은 SQL과 유사하지만, DB 테이블이 아닌 **엔티티 객체를 대상으로 쿼리를 작성한다**. 이는 객체 지향적인 방식으로 DB와 상호작용을 할 수 있게 만들어준다.

ex) `SELECT u FROM User u WHERE u.username = :username`

실제 테이블 및 컬럼이 아닌, 객체와 필드(속성)을 대상으로 쿼리를 작성한다.

