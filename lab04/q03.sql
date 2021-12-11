-- табличная функция CLR
-- возращает информацию об местах проведения, в которых проводились игротеки,
-- добавляя информацию о популярности (высокая, средняя, низкая)

CREATE OR REPLACE FUNCTION get_venues_popularity()
RETURNS
TABLE (
    venue_id UUID,
    venue_name TEXT,
    popularity TEXT
)
LANGUAGE plpython3u
AS $$
    def get_popularity(sum_dur):
        if sum_dur is None:
            return 'no info'
        elif sum_dur >= 80:
            return 'high'
        elif sum_dur >= 50:
            return 'medium'
        else:
            return 'low'

    query = """
            SELECT v.venue_id AS id, v.venue_name AS name, sum(duration) AS dur
            FROM venues v
                 LEFT JOIN
                 board_game_events bge
                 ON v.venue_id = bge.venue_id
            GROUP BY v.venue_id, v.venue_name
            """
    venues = plpy.execute(query)
    
    for venue in venues:
        yield (venue['id'], venue['name'], get_popularity(venue['dur']))
$$
    
SELECT *
FROM get_venues_popularity()
ORDER BY popularity;


-- вспомогательный
SELECT v.venue_id, v.venue_name, sum(duration) AS dur
FROM venues v
     LEFT JOIN
     board_game_events bge
     ON v.venue_id = bge.venue_id
GROUP BY v.venue_id, v.venue_name
ORDER BY dur;