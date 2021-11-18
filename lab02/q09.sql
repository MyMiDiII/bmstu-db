-- простое выражение CASE
-- подпись типа игры по максимальному числу игроков

SELECT title, producer,
       CASE max_players_num
            WHEN 1 THEN 'Наедине с собой'
            WHEN 2 THEN 'Для двоих'
            ELSE 'Для компаний больших и не очень'
       END AS game_type
FROM board_games;