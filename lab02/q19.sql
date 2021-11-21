-- UPDATE + скалярный запрос
-- у игротек без игр поменять значение
-- количества игр на среднее

UPDATE board_game_events
SET games_num = (SELECT avg(games_num)
                 FROM board_game_events)
WHERE games_num = 0;
                 

-- вспомогательные
UPDATE board_game_events
SET games_num = 0
WHERE games_num = 15;
                 
SELECT title, games_num
FROM board_game_events
ORDER BY games_num;
