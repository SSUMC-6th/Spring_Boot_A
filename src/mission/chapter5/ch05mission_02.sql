-- 미션 02 --

-- 리뷰를 작성하는 쿼리
INSERT INTO review (store_id, user_id, body, score, created_at)
VALUES (?, ?, ?, ?, NOW());