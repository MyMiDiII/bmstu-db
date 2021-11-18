-- INSERT 1 row
-- вставка игры в таблицу board_games

INSERT INTO board_games (title, producer, publication_year,
                         price, min_age, max_age, min_players_num,
                         max_players_num, min_playing_time,
                         max_playing_time)
VALUES ('BANG!', 'Hobby World', 2012, 890, 8, 99, 4, 7, 20, 40);

SELECT *
FROM board_games
ORDER BY title;