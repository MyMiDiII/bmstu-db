-- 2
-- загрузка и сохранение JSON в таблицу

CREATE TEMP TABLE json_tab(json_t json);

COPY json_tab FROM '/var/lib/postgres/data/board_games.json';

CREATE TABLE IF NOT EXISTS bg_copy
(
    game_id UUID PRIMARY KEY,
    title TEXT,
    producer TEXT,
    publication_year INT,
    price INT,
    min_age INT,
    max_age INT,
    min_players_num INT,
    max_players_num INT,
    min_playing_time INT,
    max_playing_time INT
);

INSERT INTO bg_copy
SELECT  j.*
FROM json_tab CROSS JOIN LATERAL json_populate_record(null::bg_copy, json_t) AS j

--вспомогательные запросы
SELECT *
FROM json_tab;

SELECT *
FROM bg_copy
ORDER BY title;

SELECT *
FROM board_games
ORDER BY title;

DROP TABLE bg_copy;
DROP TABLE json_tab;

-- ограничения на копию
ALTER TABLE bg_copy
ALTER COLUMN game_id SET DEFAULT uuid_generate_v4(),
ALTER COLUMN title SET NOT NULL,
ALTER COLUMN price SET NOT NULL,
ALTER COLUMN min_age SET NOT NULL,
ALTER COLUMN max_age SET NOT NULL,
ALTER COLUMN min_players_num SET NOT NULL,
ALTER COLUMN min_age SET DEFAULT 0,
ALTER COLUMN max_age SET DEFAULT 125,
ALTER COLUMN min_players_num SET DEFAULT 1,
ADD CHECK (publication_year >= 0),
ADD CHECK (price >= 0),
ADD CHECK (min_age >= 0 AND min_age <= 125),
ADD CHECK (max_age >= 0 AND max_age <= 125),
ADD CHECK (min_players_num > 0),
ADD CHECK (max_players_num > 0),
ADD CHECK (min_playing_time > 0),
ADD CHECK (max_playing_time > 0),
ADD CHECK (min_age <= max_age),
ADD CHECK (min_players_num <= max_players_num),
ADD CHECK (min_playing_time <= max_playing_time),
ADD UNIQUE (title);