-- 미션 03 --

-- `사용자`가 선택한 `지역`에 속한 `store`에서 도전 가능(`진행중`)한 `미션`의 목록 보여주기
-- 즉, 사용자의 미션도 진행중이고, 미션 자체도 진행중인 미션이여야 함
-- 데드라인을 기준으로 커서 페이징 (오름차순 정렬)

SELECT m.mission_id, m.mission_descript, m.point_reward, m.dead_line
FROM mission AS m
JOIN store AS s ON m.store_id = s.store_id
JOIN user_mission AS um ON m.mission_id = um.mission_id AND um.user_id = 3 --특정 user id
WHERE s.region_id = ? --현재 선택된 지역의 ID
      AND m.mission_status = 'in progress'  --미션의 상태가 '진행 중'
      AND um.status = 'in progress'  --사용자의 미션 상태도 '진행 중'
      AND um.complete_date IS NULL  --사용자가 아직 완료하지 않은 미션이어야 함
      AND m.dead_line > '2024-05-13 17:00:00'  --마지막으로 조회된 데드라인이 커서가 됨
ORDER BY m.dead_line ASC  --데드라인이므로, 뒤로 갈수록 미래 -> 오름차순 정렬이 필요
LIMIT 5; --페이지당 미션 5개씩 표시