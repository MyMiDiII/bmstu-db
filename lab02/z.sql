-- защита

WITH manchkin_cities
AS
(
     SELECT city, count(*) AS num
     FROM (board_game_events bge
         JOIN
         (SELECT event_id
         FROM game_event
         WHERE game_id = (SELECT game_id
                          FROM board_games
                          WHERE title = 'Munchkin')) AS mun_ev
         ON bge.event_id = mun_ev.event_id) AS tmp
         JOIN
         venues v
         ON tmp.venue_id = v.venue_id
    GROUP BY city
)
SELECT city
FROM manchkin_cities
WHERE num = (SELECT max(num) 
             FROM manchkin_cities);