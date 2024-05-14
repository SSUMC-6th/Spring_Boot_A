-- 미션 04 --

-- 01. 사용자 정보 조회
SELECT username, email, phone_number
FROM user
WHERE user_id = ?;

-- 02. 내 포인트 조회
SELECT current_point
FROM user_point
WHERE user_id = ?;

-- 03. 작성한 리뷰 조회 (10개씩 커서 페이징)
SELECT r.user_id, r.body, r.score, r.created_at, s.store_name
FROM review AS r
JOIN store s ON r.store_id = s.store_id
WHERE r.user_id = 3 AND created_at
 < (select created_at from book where r.user_id = 3) -- 특정 유저 id
ORDER BY r.created_at DESC
LIMIT 10;