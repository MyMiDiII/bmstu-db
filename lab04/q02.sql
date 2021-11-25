-- пользовательская агрегатная функция CLR
-- максимальное количество игроков на игротеке
-- в заданном городе

CREATE OR REPLACE FUNCTION get_venue_max_players(city_arg text)
RETURNS INT
LANGUAGE plpython3u
AS $$
    query = """SELECT city, players_num
               FROM venues v 
                    JOIN
                    board_game_events bge
                    ON v.venue_id = bge.venue_id;
            """
    city_and_players = plpy.execute(query)
    
    return max(row['players_num'] if row['city'] == city_arg else 0 for row in city_and_players)
$$

SELECT get_venue_max_players('Lake Ericborough');


-- вспомогательные
SELECT DISTINCT city FROM venues;

SELECT city, players_num
FROM venues v 
    JOIN
    board_game_events bge
    ON v.venue_id = bge.venue_id
ORDER BY city;