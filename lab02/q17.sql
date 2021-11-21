-- INSERT SELECT
-- добавить вторые издания
-- игр, выпущенных раньше 2000 года

INSERT INTO board_games(title, producer, publication_year,
                         price, min_age, max_age, min_players_num,
                         max_players_num, min_playing_time,
                         max_playing_time)
SELECT title || ' 2d edition', producer, publication_year + 20,
        2 * price, min_age, max_age, min_players_num,
        max_players_num, min_playing_time,
        max_playing_time
FROM board_games
WHERE publication_year < 2000;

-- вспомогательные запросы
DELETE FROM board_games
WHERE title LIKE '%2d edition';

SELECT *
FROM board_games
WHERE title LIKE '%2d edition';