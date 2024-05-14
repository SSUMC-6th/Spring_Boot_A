-- 사용자가 진행중이거나, 진행 완료한 미션 목록 조회(페이징 기능 포함)
-- 1) EXISTS 연산자와 서브쿼리, 오프셋 기반 페이징을 이용한 방식
SELECT *
FROM mission
WHERE mission_id EXISTS (
    SELECT mission_id
    FROM trying_mission
    WHERE member_id = {주어진_회원의_member_id}
    AND deleted_at is NULL
)
    AND deleted_at is NULL
limit 10 offset ({주어진_페이지_번호} - 1) * 10;


-- 2) INNER JOIN, 마감 날짜 기준으로 내림차순 정렬 후, 커서 기반 페이징을 이용한 방식
SELECT *
FROM mission as m
JOIN trying_mission as tm
ON m.mission_id = tm.mission_id
WHERE tm.member_id = {주어진_회원의_member_id}
    AND tm.deleted_at is NULL
    AND tm.due_date < (select due_date from trying_mission WHERE tyring_mission.mission_id = {커서 식별자} AND tm.deleted_at is NULL)
    OR (tm.due_date = (select due_date from trying_mission WHERE tyring_mission.mission_id = {커서 식별자} AND tm.deleted_at is NULL)
        AND tm.mission_id < {커서 식별자}
    )
ORDER BY tm.due_date DESC, tm.trying_mission_id DESC;


-- 새 리뷰를 등록(사진 제외)
INSERT INTO review
VALUES({review_id 값}, {stars 값}, {content 값}, {member_id 값}, {trying_mission_id 값}, 
    {store_id 값}, {created_at 값}, {updated_at 값}, NULL);


-- 홈 화면 쿼리
-- 1. 현재 선택한 지역에서 완료한 미션 개수 조회
SELECT count(*)
FROM trying_mission tm
JOIN mission m ON tm.mission_id = m.mission_id
WHERE tm.member_id = {나의 member_id 값}
    AND tm.is_succeeded = TRUE
    AND m.store_id EXISTS (
        SELECT store_id
        FROM store
        WHERE region = {현재 선택한 지역}
            AND store.deleted_at is NULL;
    )
    AND tm.deleted_at is NULL
GROUP BY tm.member_id;


-- 2. 현재 선택한 지역에서 도전 가능한 미션 목록 조회(페이징 기능 포함)
SELECT *
FROM mission
WHERE store_id EXISTS (
    SELECT store_id
    FROM store
    WHERE region = {현재 선택한 지역}
        AND store.deleted_at is NULL;
)
    AND deleted_at is NULL;


-- 마이페이지 화면. 내 정보 조회
SELECT *
FROM member
WHERE member_id = {나의 member_id 값};