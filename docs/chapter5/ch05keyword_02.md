# 서브쿼리

---

- 하나의 SQL문 안에 포함되어 있는 또 다른 SQL문
- `괄호()` 안에 있는 쿼리를 서브 쿼리라고 한다.
- 실행 순서: 서브쿼리 실행 → 메인쿼리 실행
- 서브쿼리는 `ORDER BY`를 사용할 수 없다.


💡 `서브쿼리(=자식쿼리)` : 메인쿼리 컬럼 사용 가능
`메인쿼리(=부모쿼리)` : 서브쿼리 컬럼 사용 불가

- Java 객체지향의 상속과 똑같은 개념이다.
- 자식 객체는 부모 객체의 인스턴스를 사용할 수 있고, 부모는 자식객체의 인스턴스를 사용할수 없다.


### 중첩 서브쿼리 - where절 안의 서브쿼리

---

- 조건 값을 상수로 할 때
    
    ```sql
    select name, height 
    from userTbl
    where height > 177;
    ```
    

- 조건값을 select로 특정할 때 (단, 결괏값이 하나여야 한다)
    
    ```sql
    select name, height 
    from userTbl
    where height > (select height from userTbl where name in ('김경호'));
    ```
    

- 조건에 값이 여러 개 들어올 때 → **any**
    - 어느 하나라도 조건을 만족하면 테이블에 출력
    - `in`과 동일한 의미
    
    ```sql
    select name, height 
    from userTbl
    where height = any(select height from userTbl where addr in ('경남'));
    ```
    

- 조건에 값이 여러 개 들어올 때 → **all**
    - 모든 컬럼이 조건을 만족해야지만 테이블에 출력
    
    ```sql
    select * 
    from city
    where population > all( select population from city where district = 'New York' );
    ```
    

### 인라인 뷰 (inline view) - from절 안의 서브쿼리

---

- **서브쿼리가 FROM 절에 사용될 경우 무조건 AS 별칭을 지정해 주어야 한다.**
- 예제
    
    ```sql
    SELECT EX1.name,EX1.salary
    FROM (
      SELECT * FROM employee AS Ii
      WHERE Ii.office_worker='사원'
    ) EX1; //서브쿼리 별칭
    ```
    

### 스칼라 서브쿼리 - select절 안의 서브쿼리

---

- 다른 테이블에서 어떠한 값을 가져올 때
- **하나의 레코드만 리턴** 가능하며, 두 개 이상의 레코드는 리턴할 수 없다.
- 일치하는 데이터가 없더라도 **NULL값을 리턴**할 수 있다.
- 예제
    
    ```sql
    SELECT player_name, height, (
    	SELECT AVG(height) FROM player as p
    	WHERE p.team_id = x.team_id 
    	) as AVG_height
    FROM player as x
    ```