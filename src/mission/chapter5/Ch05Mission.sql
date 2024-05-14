# 내가 진행중, 진행 완료한 미션 모아서 보는 쿼리(페이징 포함)
SELECT *
FROM Mission m
         JOIN User_Mission um ON m.id = um.mission_id
WHERE um.user_id = 1 -- 1은 자기 자신의 id
  AND (status = 'in_progress' OR status = 'completed')
order by m.updated_at desc
    limit 10 offset (n-1)*10;



# 리뷰 작성
INSERT INTO Review (id, user_id, store_id, body, updated_at, created_at, score)
VALUES (1, 1, 1, '강력 추천합니다!', NOW(), NOW(), 4.5);

# 홈 화면 쿼리 (현재 선택 된 지역에서 도전이 가능한 미션 목록, 페이징 포함)
select *
from (SELECT m.id, m.name, m.point, s.name AS store_name
      FROM Mission m
               JOIN Store s ON m.store_id = s.id
      WHERE s.location_id = (SELECT id
                             FROM Location
                             WHERE name = '지역명')
        AND m.created_at < (select created_at from Mission where id = 4) -- 4가 마지막으로 조회한 mission
      ORDER BY m.created_at DESC
          LIMIT 10) ms;


# 마이 페이지 화면 쿼리
SELECT u.email, u.name, u.phone_number, u.point
FROM User u
WHERE u.id = 1; -- 1은 자기 자신의 id
