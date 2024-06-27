# Chapter 10. API & Paging

> UMC 워크북 10주차 키워드에 관한 내용을 정리해보겠습니다 :)

# 1-1. Page

`Page` 인터페이스는 페이징된 데이터를 포함하며, 페이지에 대한 메타데이터(예: 총 페이지 수, 전체 데이터 개수 등)도 제공한다. `Page`는 `Slice`를 확장하며, 더 많은 메서드를 제공한다.

## **Method**

- `getContent()`: 현재 페이지의 데이터 리스트를 반환
- `getTotalElements()`: 전체 데이터 개수를 반환
- `getTotalPages()`: 전체 페이지 수를 반환
- `getNumber()`: 현재 페이지 번호를 반환 (0부터 시작)
- `getSize()`: 페이지 당 데이터 개수를 반환
- `hasNext()`: 다음 페이지가 있는지 여부를 반환
- `hasPrevious()`: 이전 페이지가 있는지 여부를 반환

## **예시:**

```java
Pageable pageable = PageRequest.of(0, 10); // 첫 번째 페이지, 페이지당 10개 항목
Page<User> page = userRepository.findAll(pageable);

List<User> users = page.getContent();
int totalPages = page.getTotalPages();
long totalItems = page.getTotalElements();
boolean hasNext = page.hasNext();
```

# 1-2. Slice

`Slice` 인터페이스는 `Page`와 유사하지만, 전체 페이지 수나 전체 데이터 개수를 제공하지 않는다. 주로 다음 페이지가 있는지 여부만 확인하는 데 사용된다.

## **주요 메서드**:

- `getContent()`: 현재 페이지의 데이터 리스트를 반환
- `hasNext()`: 다음 페이지가 있는지 여부를 반환
- `hasPrevious()`: 이전 페이지가 있는지 여부를 반환

## **예제 코드**:

```java
Pageable pageable = PageRequest.of(0, 10); // 첫 번째 페이지, 페이지당 10개 항목
Slice<User> slice = userRepository.findAll(pageable);

List<User> users = slice.getContent();
boolean hasNext = slice.hasNext();
```

# 1-3. 차이점

`Page` 인터페이스는 페이징된 데이터를 포함하며, 페이지 메타데이터(예: 총 페이지 수, 전체 데이터 개수 등)를 제공한다. 이를 통해 사용자는 전체 데이터셋에 대한 보다 포괄적인 정보를 얻을 수 있다.

`Slice` 인터페이스는 `Page`와 유사하지만, 전체 페이지 수나 전체 데이터 개수에 대한 정보를 제공하지 않는다. 대신, 현재 페이지와 다음 페이지가 있는지 여부만 확인할 수 있다. `Slice`는 주로 전체 데이터셋에 대한 정보가 필요 없고, 단순히 다음 페이지로 넘어갈 수 있는지 여부만 필요할 때 사용된다.

| 특징 | Page | Slice |
| --- | --- | --- |
| 전체 데이터 개수 제공 | 예 (getTotalElements()) | 아니오 |
| 전체 페이지 수 제공 | 예 (getTotalPages()) | 아니오 |
| 다음 페이지 여부 제공 | 예 (hasNext()) | 예 (hasNext()) |
| 이전 페이지 여부 제공 | 예 (hasPrevious()) | 예 (hasPrevious()) |
| 현재 페이지 번호 제공 | 예 (getNumber()) | 예 (getNumber()) |
| 페이지 내 데이터 제공 | 예 (getContent()) | 예 (getContent()) |

## 선택 기준

- **`Page`를 사용해야 하는 경우**: 전체 데이터셋의 크기나 총 페이지 수 등의 메타데이터가 필요한 경우.
- **`Slice`를 사용해야 하는 경우**: 전체 데이터셋의 크기나 총 페이지 수가 필요 없고, 다음 페이지로 이동할 수 있는지 여부만 필요한 경우.

# 2. 객체 그래프 탐색

객체 그래프 탐색(Object Graph Navigation)은 JPA 엔티티 간의 연관 관계를 탐색하여 관련된 데이터를 로드하는 작업을 의미한다. 이는 객체 지향적인 방식으로 데이터를 관리하고, 관계형 데이터베이스의 관계를 객체 간의 관계로 매핑하는 데 사용된다.

## 로딩 전략

- **즉시 로딩(Eager Loading)**:
  연관된 엔티티를 즉시 로드한다. 엔티티가 조회될 때 연관된 모든 엔티티도 함께 로드된다.

    ```java
    @ManyToOne(fetch = FetchType.EAGER)
    private Department department;
    ```

- **지연 로딩(Lazy Loading)**:
  연관된 엔티티를 실제로 사용할 때까지 로드하지 않는다. 프록시 객체를 사용하여 실제 엔티티 접근 시점에 로드된다.

    ```java
    @OneToMany(fetch = FetchType.LAZY)
    private List<Employee> employees;
    ```


## N+1 문제

지연 로딩을 사용할 때, 여러 연관 엔티티를 반복적으로 접근하면 N+1 문제가 발생할 수 있다. 이는 한 번의 메인 쿼리 후 N번의 추가 쿼리가 발생하는 상황을 말한다. 이를 해결하기 위해 JPQL의 페치 조인을 사용할 수 있다.

**예제**:

```java
// JPQL 페치 조인 예제
String jpql = "SELECT d FROM Department d JOIN FETCH d.employees WHERE d.id = :id";
Department department = entityManager.createQuery(jpql, Department.class)
                                      .setParameter("id", departmentId)
                                      .getSingleResult();
```

# 3. JPQL

JPQL은 JPA에서 제공하는 **객체 지향 쿼리 언어**로, 엔티티 객체를 대상으로 쿼리를 작성한다. SQL과 유사하지만, 테이블이 아닌 엔티티 객체와 속성을 기준으로 쿼리를 작성한다.

## 기본 문법

- **SELECT**: 데이터를 조회하는 쿼리.

    ```java
    String jpql = "SELECT u FROM User u WHERE u.name = :name";
    List<User> users = entityManager.createQuery(jpql, User.class)
                                    .setParameter("name", "John")
                                    .getResultList();
    ```

- **UPDATE**: 데이터를 업데이트하는 쿼리.

    ```java
    String jpql = "UPDATE User u SET u.active = false WHERE u.lastLogin < :date";
    int updatedCount = entityManager.createQuery(jpql)
                                    .setParameter("date", LocalDate.now().minusDays(30))
                                    .executeUpdate();
    ```

- **DELETE**: 데이터를 삭제하는 쿼리.

    ```java
    String jpql = "DELETE FROM User u WHERE u.active = false";
    int deletedCount = entityManager.createQuery(jpql)
                                    .executeUpdate();
    ```


## JOIN

연관된 엔티티를 함께 조회할 때 사용된다.

```java
String jpql = "SELECT o FROM Order o JOIN o.customer c WHERE c.name = :name";
List<Order> orders = entityManager.createQuery(jpql, Order.class)
                                  .setParameter("name", "John")
                                  .getResultList();
```

## 네임드 쿼리

엔티티 클래스에 정의된 정적 쿼리로, 재사용 가능하고 관리하기 쉽다.

```java
@Entity
@NamedQuery(name = "User.findByName", query = "SELECT u FROM User u WHERE u.name = :name")
public class User { ... }

// 사용 예제
List<User> users = entityManager.createNamedQuery("User.findByName", User.class)
                                .setParameter("name", "John")
                                .getResultList();
```

## JPQL 고급 기능

- **서브쿼리**:
  JPQL은 서브쿼리를 지원하여 복잡한 쿼리를 작성할 수 있다.

    ```java
    String jpql = "SELECT u FROM User u WHERE u.id IN (SELECT o.user.id FROM Order o WHERE o.amount > 100)";
    List<User> users = entityManager.createQuery(jpql, User.class)
                                    .getResultList();
    ```

- **함수**:
  JPQL은 여러 내장 함수를 제공하여 쿼리를 더욱 유연하게 작성할 수 있다.

    ```java
    String jpql = "SELECT FUNCTION('YEAR', o.orderDate) FROM Order o WHERE o.amount > 100";
    List<Integer> years = entityManager.createQuery(jpql, Integer.class)
                                       .getResultList();
    ```

- **그룹핑 및 집계**:
  집계 함수와 그룹핑을 사용하여 데이터를 요약할 수 있다.

    ```java
    String jpql = "SELECT c.name, COUNT(o) FROM Customer c JOIN c.orders o GROUP BY c.name";
    List<Object[]> results = entityManager.createQuery(jpql)
                                          .getResultList();
    for (Object[] result : results) {
        String name = (String) result[0];
        Long count = (Long) result[1];
        System.out.println(name + ": " + count);
    ```
  
