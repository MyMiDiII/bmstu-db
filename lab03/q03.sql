-- многооператорная табличная функция,
-- обновляющая количество игр на игротеках
-- и возращающая информацию об обновлении

CREATE OR REPLACE FUNCTION update_games_num()
RETURNS TABLE (
    event_id UUID,
    title TEXT,
    num_from INT,
    num_to INT,
    update_date DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    CREATE TEMP TABLE IF NOT EXISTS prev_nums
    (
        event_id UUID,
        games_num int
    );
    
    INSERT INTO prev_nums
    SELECT bge.event_id, games_num
    FROM board_game_events bge;

    UPDATE board_game_events
    SET games_num = rel_vals.games_num
    FROM (SELECT ge.event_id, count(*) AS games_num
          FROM game_event ge
          GROUP BY ge.event_id) AS rel_vals
    WHERE board_game_events.event_id = rel_vals.event_id;
    
    RETURN QUERY
        (SELECT bge.event_id, bge.title, bge.games_num, pn.games_num, current_date
         FROM prev_nums pn
              JOIN
              board_game_events bge
              ON pn.event_id = bge.event_id
          WHERE bge.games_num != pn.games_num);
END
$$

SELECT *
FROM update_games_num();




-- вспомогательные
SELECT *
FROM board_game_events;

DROP TABLE board_game_events CASCADE;

CREATE TABLE IF NOT EXISTS board_game_events (
    event_id UUID PRIMARY KEY,
    venue_id UUID,
    org_id UUID,
    title TEXT,
    event_date DATE,
    start_time TIME,
    duration INT,
    players_num INT,
    games_num INT,
    purchase BOOLEAN
);

COPY board_game_events
FROM '/var/lib/postgres/data/csv/board_game_events.csv'
DELIMITER ',' CSV;