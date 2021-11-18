-- оконные функции + min/max/avg over()
-- для каждого типа мест проведение
-- посчитать минимальное, максимальное и среднее
-- число участиков всех проведенных в них игротек

SELECT DISTINCT v.venue_id, venue_name, vanue_type,
       min(bge.players_num) OVER(PARTITION BY vanue_type) AS min_num,
       max(bge.players_num) OVER(PARTITION BY vanue_type) AS max_num,
       avg(bge.players_num) OVER(PARTITION BY vanue_type) AS avg_num
FROM venues v
     LEFT JOIN
     board_game_events bge
     ON v.venue_id = bge.venue_id
ORDER BY v.vanue_type;