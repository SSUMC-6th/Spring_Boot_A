# Chapter 7. JPA를 통한 엔티티 설계, 매핑 & 프로젝트 파일 구조 이해

> UMC 워크북 7주차 키워드에 관한 내용을 정리해보겠습니다 :)

# ✅ 1. 영속성 컨텍스트

JPA(Java Persistence API)의 영속성 컨텍스트(persistence context)는 엔티티 객체의 생명 주기를 관리하고, 데이터베이스와의 동기화를 책임지는 메커니즘이다. 이를 통해 엔티티의 상태를 일관성 있게 유지하고, 효율적인 데이터베이스 접근을 가능하게 한다.

### **영속성 컨텍스트의 정의**

영속성 컨텍스트는 엔티티 매니저(EntityManager)가 관리하는 엔티티 객체의 집합이다. 엔티티 객체가 영속성 컨텍스트에 포함되면, 그 객체는 데이터베이스와의 동기화를 통해 상태가 관리된다. 즉, 영속성 컨텍스트는 엔티티 객체와 데이터베이스 사이의 상태를 매핑하고 조정하는 역할을 한다.

### **엔티티 상태**

엔티티 객체는 네 가지 상태를 가질 수 있다:

1. **비영속 (Transient)**: 영속성 컨텍스트와 관계가 없는 상태. 아직 데이터베이스에 저장되지 않음.
2. **영속 (Managed)**: 영속성 컨텍스트에 포함된 상태. 이 상태에서는 엔티티가 영속성 컨텍스트에 의해 관리되고, 변경이 자동으로 감지되어 데이터베이스에 반영된다.
3. **준영속 (Detached)**: 영속성 컨텍스트에서 분리된 상태. 데이터베이스에는 존재하지만, 영속성 컨텍스트에서 관리되지 않는다.
4. **삭제 (Removed)**: 영속성 컨텍스트에 의해 삭제된 상태. 트랜잭션이 커밋되면 데이터베이스에서도 삭제된다.

### **주요 역할**

### **1. 엔티티 생명 주기 관리**

영속성 컨텍스트는 엔티티 객체의 생명 주기를 관리한다. 예를 들어, 엔티티가 영속성 컨텍스트에 추가되면 **`persist`** 상태가 되고, 엔티티의 변경이 감지되면 데이터베이스에 반영된다.

```java
EntityManager em = entityManagerFactory.createEntityManager();
em.getTransaction().begin();

Member member = new Member();
member.setName("John");
em.persist(member);  // 영속 상태로 변경

em.getTransaction().commit();
em.close();
```

### **2. 변경 감지 (Dirty Checking)**

영속성 컨텍스트는 엔티티 객체의 상태 변화를 감지한다. 트랜잭션이 끝날 때 자동으로 변경 사항이 데이터베이스에 반영된다.

```java
em.getTransaction().begin();
member.setName("Doe");  // 변경 감지
em.getTransaction().commit();  // 변경 사항이 데이터베이스에 반영됨
```

### **3. 1차 캐시 (First-Level Cache)**

영속성 컨텍스트는 동일한 트랜잭션 내에서 동일한 엔티티에 대한 여러 번의 조회 요청을 캐싱하여 데이터베이스에 대한 불필요한 접근을 방지한다.

```java
Member member1 = em.find(Member.class, 1L);
Member member2 = em.find(Member.class, 1L);  // 데이터베이스 조회 없이 캐시에서 반환
```

### **4. 지연 로딩 (Lazy Loading)**

지연 로딩은 실제로 필요한 시점에 연관된 엔티티를 로딩하여 성능을 최적화한다. 이는 영속성 컨텍스트가 연관 엔티티를 실제로 사용할 때까지 로딩을 지연시키는 방식이다.

### **엔티티 매니저 (EntityManager)**

엔티티 매니저는 영속성 컨텍스트를 관리하는 객체이다. 주요 기능으로는 **`persist`**, **`merge`**, **`remove`**, **`find`** 등이 있다.

```java
em.persist(newEntity);  // 엔티티를 영속 상태로 만듦
Member foundMember = em.find(Member.class, 1L);  // 엔티티 조회
em.remove(foundMember);  // 엔티티 삭제

```

### **트랜잭션과 영속성 컨텍스트**

트랜잭션은 영속성 컨텍스트를 통해 데이터베이스와 상호작용한다. 트랜잭션이 시작되면 영속성 컨텍스트가 활성화되고, 트랜잭션이 커밋되거나 롤백되면 영속성 컨텍스트가 변경 사항을 데이터베이스에 반영하거나 버린다.

```java
em.getTransaction().begin();
em.persist(entity);
em.getTransaction().commit();  // 변경 사항이 데이터베이스에 반영됨
```

### **영속성 컨텍스트의 전파**

트랜잭션 전파(Transaction Propagation)를 통해 여러 서비스 계층 간에 동일한 영속성 컨텍스트를 사용할 수 있다. 이는 트랜잭션 내에서 일관된 엔티티 상태를 유지하는 데 도움이 된다.

이처럼 영속성 컨텍스트는 JPA에서 매우 중요한 개념으로, 엔티티의 상태를 관리하고 데이터베이스와의 상호작용을 추상화하여 개발자가 효율적으로 데이터를 다룰 수 있도록 한다.


# ✅ 2. 양방향 매핑
양방향 매핑은 JPA에서 두 엔티티가 서로를 참조하는 관계를 의미한다. 이는 객체 지향적으로는 서로 연관된 두 객체가 있고, 관계형 데이터베이스 관점에서는 두 테이블이 외래 키를 통해 연결된 상황을 반영한다. 양방향 매핑은 특히 복잡한 도메인 모델을 다루는 데 유용하지만, 잘못 사용하면 성능 문제나 데이터 일관성 문제를 초래할 수 있다. 따라서 이를 이해하고 적절히 사용하는 것이 중요하다.

### **양방향 매핑의 구성 요소**

1. **주인 엔티티(Owner)**: 관계의 주도권을 갖고 외래 키를 관리하는 엔티티이다.
2. **종속 엔티티(Inverse/Referenced Entity)**: 주인 엔티티의 관계를 참조하는 엔티티이다.

### **예제: `Member`와 `Team` 엔티티**

```java
@Entity
public class Member {
    @Id @GeneratedValue
    private Long id;
    private String name;

    @ManyToOne
    @JoinColumn(name = "team_id")  // 외래 키
    private Team team;

    // Getter, Setter
}

@Entity
public class Team {
    @Id @GeneratedValue
    private Long id;
    private String name;

    @OneToMany(mappedBy = "team")  // 연관 관계의 주인이 아님
    private List<Member> members = new ArrayList<>();

    // Getter, Setter
}
```

### **주요 개념**

### **주인 엔티티와 종속 엔티티**

- **`Member`** 엔티티의 **`team`** 필드는 **`@ManyToOne`** 어노테이션을 사용하여 **`Team`** 과의 관계를 나타내며, 외래 키를 관리한다. 즉, **`Member`** 가 관계의 주인이다.
- **`Team`** 엔티티의 **`members`** 필드는 **`@OneToMany(mappedBy = "team")`** 어노테이션을 사용하여 **`Member`** 와의 관계를 나타내며, **`mappedBy`** 속성은 관계의 주인을 지정한다. 여기서 **`Team`** 은 관계의 종속 엔티티이다.

### **양방향 매핑의 장점**

1. **탐색 편의성**: 양방향 관계를 통해 양쪽에서 쉽게 관계를 탐색할 수 있다. 예를 들어, **`Member`** 객체를 통해 **`Team`** 을, **`Team`** 객체를 통해 **`Member`** 목록을 조회할 수 있다.
2. **도메인 모델 표현력 향상**: 도메인 모델을 더 직관적이고 현실 세계의 관계에 가깝게 표현할 수 있다.

### **양방향 매핑의 단점**

1. **데이터 일관성 문제**: 양방향 관계에서는 두 엔티티 사이의 관계가 항상 일관되게 유지되도록 관리해야 한다.
2. **복잡성 증가**: 매핑 설정과 데이터 동기화가 복잡해질 수 있다.
3. **성능 이슈**: 잘못된 매핑이나 과도한 데이터 로딩으로 인해 성능 문제가 발생할 수 있다.

### **데이터 일관성 유지**

양방향 매핑에서는 두 엔티티 사이의 관계를 일관되게 유지하는 것이 중요하다. 예를 들어, **`Member`** 가 **`Team`** 을 변경하면, 해당 **`Team`** 의 **`members`** 리스트에서도 일관되게 반영해야 한다.

### **예제 코드**

```java
public void addMemberToTeam(Member member, Team team) {
    member.setTeam(team);  // Member의 team 설정
    team.getMembers().add(member);  // Team의 members 설정
}
```

이처럼 엔티티 간의 관계가 변경될 때, 양쪽에서 일관성을 유지하도록 코드를 작성해야 한다.

### **지연 로딩과 즉시 로딩**

- **`@ManyToOne`** 과 **`@OneToMany`** 관계에서 기본 로딩 전략은 지연 로딩(Lazy Loading)이다. 이는 연관된 엔티티가 실제로 사용될 때 데이터베이스에서 로드되는 방식이다.
- 즉시 로딩(Eager Loading)은 관계된 모든 데이터를 즉시 로드하는 방식으로, **`fetch = FetchType.EAGER`** 로 설정할 수 있다. 그러나 성능 문제가 발생할 수 있어 신중히 사용해야 한다.

### **지연 로딩 예제**

```java
@ManyToOne(fetch = FetchType.LAZY)
@JoinColumn(name = "team_id")
private Team team;
```

### **결론**

양방향 매핑은 도메인 모델을 보다 직관적이고 현실 세계의 관계에 가깝게 만들 수 있는 강력한 기능이다. 그러나 데이터 일관성을 유지하기 위해 신중하게 설계하고, 성능 문제를 피하기 위해 지연 로딩 등 최적화 기법을 적절히 사용해야 한다. 이를 통해 복잡한 엔티티 관계를 효과적으로 관리할 수 있다.

# ✅ 3. N+1 문제

N+1 문제는 JPA와 같은 ORM(Object-Relational Mapping) 프레임워크에서 흔히 발생하는 성능 문제 중 하나이다. 이 문제는 주로 연관된 엔티티를 조회할 때 발생하며, 잘못된 쿼리 실행으로 인해 성능 저하를 초래한다. 

### **N+1 문제의 정의**

N+1 문제는 한 번의 쿼리로 N개의 데이터를 조회한 후, 각 데이터에 대해 추가적인 쿼리가 실행되면서 총 N+1개의 쿼리가 실행되는 상황을 말한다. 이는 데이터베이스에 불필요한 쿼리를 다수 실행하게 되어 성능에 큰 영향을 미친다.

### **예시**

**`Member`** 와 **`Team`** 엔티티가 1:N 관계를 가지고 있다고 가정해보자.

### **엔티티 설정**

```java
@Entity
public class Member {
    @Id @GeneratedValue
    private Long id;
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "team_id")
    private Team team;

    // Getter, Setter
}

@Entity
public class Team {
    @Id @GeneratedValue
    private Long id;
    private String name;

    @OneToMany(mappedBy = "team")
    private List<Member> members = new ArrayList<>();

    // Getter, Setter
}
```

### **N+1 문제 발생 코드**

```java
List<Member> members = em.createQuery("SELECT m FROM Member m", Member.class).getResultList();

for (Member member : members) {
    System.out.println(member.getTeam().getName());
}
```

위의 코드에서 **`SELECT m FROM Member m`** 쿼리를 실행하여 모든 **`Member`** 엔티티를 조회한다. 이 때, 각 **`Member`** 의 **`Team`** 엔티티를 접근할 때마다 추가적인 쿼리가 실행된다.

### **쿼리 실행 과정**

1. 첫 번째 쿼리:
    
    ```sql
    SELECT * FROM Member;
    ```
    
2. **`N`**개의 추가 쿼리 (각 **`Member`** 의 **`Team`** 조회):
    
    ```sql
    SELECT * FROM Team WHERE id = ?;
    ```
    

즉, 처음 **`Member`** 엔티티를 조회하는 쿼리 1번과 각 **`Member`** 의 **`Team`** 을 조회하는 추가 쿼리 **`N`** 번이 실행되어 총 **`N+1`** 번의 쿼리가 발생한다.

### **해결 방법**

N+1 문제를 해결하는 방법으로는 주로 **페치 조인(Fetch Join)과 엔티티 그래프(Entity Graph)** 를 사용한다.

### **1. 페치 조인 (Fetch Join)**

페치 조인은 한 번의 쿼리로 연관된 엔티티를 함께 조회하는 방법이다.

```java
List<Member> members = em.createQuery(
    "SELECT m FROM Member m JOIN FETCH m.team", Member.class)
    .getResultList();

```

위 쿼리는 **`Member`** 와 연관된 **`Team`** 을 한 번에 조회하여 추가적인 쿼리를 방지한다.

### **2. 엔티티 그래프 (Entity Graph)**

엔티티 그래프를 사용하여 특정 쿼리에서 연관된 엔티티를 함께 로딩하도록 설정할 수 있다.

```java
@Entity
@NamedEntityGraph(name = "Member.team",
    attributeNodes = @NamedAttributeNode("team"))
public class Member {
    // ...
}

// 쿼리 실행 시 엔티티 그래프 사용
EntityGraph<Member> graph = em.createEntityGraph(Member.class);
graph.addAttributeNodes("team");

List<Member> members = em.createQuery("SELECT m FROM Member m", Member.class)
    .setHint("javax.persistence.loadgraph", graph)
    .getResultList();
```

### **요약**

N+1 문제는 연관된 엔티티를 조회할 때 발생하는 성능 문제로, **한 번의 쿼리로 N개의 데이터를 조회한 후** 각 데이터에 대해 **추가적인 쿼리가 실행**되면서 발생한다. 이를 해결하기 위해 페치 조인이나 엔티티 그래프를 사용하여 불필요한 쿼리 실행을 줄이고 성능을 최적화할 수 있다. N+1 문제는 특히 많은 데이터가 연관된 경우 성능에 큰 영향을 미치므로, 이를 방지하고 최적화하는 것이 중요하다.