-- group by без having
-- для каждого антикафе получить
-- средную продолжительность игротек
-- и максимальное количество игроков

SELECT v.venue_id, venue_name,
       ROUND(AVG(duration),1) AS avg_duration,
       MAX(players_num) AS max_players_num
FROM venues v
     LEFT JOIN board_game_events bge
     ON v.venue_id = bge.venue_id
WHERE vanue_type = 'anti-cafe'
GROUP BY v.venue_id, venue_name;
