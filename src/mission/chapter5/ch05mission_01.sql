-- 미션 01 --

-- 진행중 → 미션 시작한 최신순으로 3개 보이게 페이징
-- 이전 페이지의 마지막 start_date를 불러와서 더 과거에 시작된 미션을 보여준다. (최신순)
    

SELECT m.*
FROM mission m
JOIN user_mission um ON m.mission_id = um.mission_id
WHERE um.user_id = 3 //특정 user id
    AND um.status = 'in progress'
    AND um.start_date < '2024-05-13 17:00:00' //이전 페이지의 마지막 start_date 불러오기
ORDER BY um.start_date DESC
LIMIT 3;
    
    
-- 진행 완료 → 미션 완료한 최신순으로 3개 보이게 페이징
-- 이전 페이지의 마지막 complete_date를 불러와서 더 과거에 완료된 미션을 보여준다. (최신순)

SELECT m.*
FROM mission m
JOIN user_mission um ON m.mission_id = um.mission_id
WHERE um.user_id = 3  --특정 user id
    AND um.status = 'completed'
    AND um.complete_date < '2024-05-13 17:00:00' --이전 페이지의 마지막 complete_date 불러오기
ORDER BY um.complete_date DESC
LIMIT 3;