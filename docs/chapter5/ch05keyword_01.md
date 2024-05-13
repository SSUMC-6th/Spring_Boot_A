# JOIN에 대해..

---

- 여러 번 join할 수 있음
- 같은 이름의 속성값을 가진 테이블을 join할 경우 테이블 이름으로 구별해주어야 함
    - ex) A 테이블, B 테이블이 있을 때 **A.속성** / **B.속성**으로 구별
- **테이블명 as ___** 로 별칭을 지정할 수 있음


조건절에 부합하는 행이 서로의 테이블에 두개 이상 있으면 
(ex. `a.id = b.id` 조건일 때 특정 id가 a에 2개 이상, b에도 2개 이상 있을 경우)
→ 모든 가능한 조합으로 생성된다.


> 조인은 집합간의 곱의 관계이다.
> 따라서 1:1 관계 테이블이 조인하면 1(1*1) 레벨의 집합이 생성되고,
> 1:M 관계가 조인하면 M(1*M) 레벨의 집합이 된다.
> 마찬가지로 M:N 관계가 조인하면 MN 레벨의 집합이 된다.
> (서브쿼리는 서브쿼리 레벨과는 상관없이 항상 메인쿼리 레벨로 생성됨)


### LEFT OUTER JOIN

---

> 양쪽에 있는 정보는 물론 + 왼쪽에만 있는 정보도 같이 출력

> tableB **LEFT JOIN** tableA ON 조건

- 왼쪽 테이블 것은 일단 모두 가져온다고 생각
- 두 테이블이 합쳐 질때 왼쪽/오른쪽을 기준으로 했느냐에 따라 기준 테이블의 것은 모두 출력되어야 한다.

- 왼쪽 테이블을 기준으로, 조건에 부합하는 오른쪽 테이블을 채운다.
    - 조건에 해당하는 값이 없으면 오른쪽 테이블은 다 NULL로 채운다.

부합하지 않는 행들은 NULL로 표현되는 것을 감수하면서도 값을 가져온다는 특징.


💡 left join 했을때 `null`이 채워져 있다 →
왼쪽에만 값이 존재하고, 그 값에 해당하는 오른쪽 테이블의 행이 없다는 뜻


💡 조인을 여러 번 해야하는데 시작을 LEFT JOIN으로 했다면 나머지 조인도 LEFT JOIN을 이어나간다.


### INNER JOIN

---

> 양쪽에만 있는 정보를 출력


> tableB **inner join** tableA **on** 조건


- 그냥 Join을 쓰면 inner join을 말함
- 양쪽 모두에 존재하는 행만을 가지고 새로운 표를 만드는 것
    - 따라서 null 행이 존재하지 않는다.

만약 조건이 a.id=b.id 라면 두 테이블 모두 같은 아이디가 존재해야 한다.

Left join 이후 null로 채워진 행을 삭제하는 거라고 봐도 될 듯하다

### FULL OUTER JOIN

---



> (tableB **left join** tableA **on** 조건) **UNION** (tableB **right join** tableA **on** 조건)


대부분 이 구문을 직접적으로 지원하지는 않기 때문에,

left join한 결과와 rigt join한 결과를 합쳐서 중복 제거하는 방법으로 구현한다.

- Left Join, Right Join을  각각 진행한 후, 합집합으로 이어붙여서 모두 하나의 테이블이 되는 형태
- 이때 UNION은 중복을 제거시킨다. (`distinct` 키워드가 생략되어 있음)
    - 중복되는 행까지 모두 출력하고 싶다면 `UNION ALL` 키워드 사용

### Exclusive LEFT JOIN

---

> 왼쪽 테이블에만 있는 행을 가져온다. (둘 다 가지고 있는 행은 제외)


> tableB **LEFT JOIN** tableA **ON** 조건 **WHERE** tableA.조건속성 **is NULL**


- 이어붙인 테이블이 NULL일 때만 조회한다 → 왼쪽 테이블 중, inner join했을 때의 행를 뺀다.
- 오른쪽 테이블에는 없고 유일하게 왼쪽 테이블에만 존재하는  것을 가져올 수 있다.
    - 즉, **오른쪽 테이블의 primary key가 null인 행만 남기고 나머지는 안보이게!**

참고 유튜브 링크

[SQL JOIN - 6. FULL OUTER JOIN](https://www.youtube.com/watch?v=Zn-cECPEORU&list=PLuHgQVnccGMAG1O1BRZCT3wkD_aPmPylq&index=7)

### 중복된 레코드 제거

---

1. `distinct` 키워드 사용
    - 레코드 수가 많은 경우 성능이 느리다
    - 예제
        
        ```sql
        SELECT DISTINCT person.id, person.name, job.job_name 
        FROM person INNER JOIN job 
        ON person.name = job.person_name;
        ```
        

1. 서브쿼리를 사용해 중복을 제거한 후 JOIN하기
    - 서브쿼리를 통해, 조인할 테이블을 `distinct`로 중복을 제거한 테이블로 만든 뒤 조인한다
    - 예제
        
        ```sql
        select A.name, A.countryCode 
        from city A 
        left join ( select distinct name, Code from country ) as B 
        on A.countrycode = B.Code
        ```