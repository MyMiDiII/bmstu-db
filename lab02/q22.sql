-- простое обобщенное табличное выражение
-- среднее количество игротек, проведенных
-- одним огранизатором

WITH org_stats (org_id, events_num) AS (
    SELECT o.org_id, count(*)
    FROM board_game_events bge
         RIGHT JOIN
         organizers o
         ON bge.org_id = o.org_id
    GROUP BY o.org_id
)
SELECT avg(events_num) AS avg_events_by_one_org
FROM org_stats;
