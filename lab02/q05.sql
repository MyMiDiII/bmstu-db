-- EXISTS + вложенный подзапрос
-- получить список игротек, на которых
-- хотя бы одна игра для детей (максимальный возраст 6)

SELECT title, event_date
FROM board_game_events bge 
WHERE EXISTS (
    SELECT ewg.event_id 
    FROM (board_games bg JOIN game_event ge
         ON bg.game_id = ge.game_id) AS ewg
    WHERE ewg.max_age = 6 AND ewg.event_id = bge.event_id
);