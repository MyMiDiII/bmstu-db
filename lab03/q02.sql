-- подставляемая табличная функция,
-- возращающая места проведения, в которых
-- играют в игру с именем, передающимся
-- в качестве параметра

CREATE OR REPLACE FUNCTION game_cities(arg_title TEXT)
RETURNS TABLE (id uuid, v_name TEXT, city text)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
        SELECT v.venue_id, v.venue_name, v.city
        FROM (board_game_events bge
            JOIN
            (SELECT event_id
            FROM game_event
            WHERE game_id = (SELECT game_id
                             FROM board_games
                             WHERE title = arg_title)) AS ev
            ON bge.event_id = ev.event_id) AS tmp
            JOIN
            venues v
            ON tmp.venue_id = v.venue_id;
END
$$

SELECT *
FROM game_cities('Munchkin');