-- тип данных CLR
-- сотрудничество огранизаторов и мест проведений

CREATE TYPE collaboration AS (
    venue TEXT,
    org   TEXT
);

CREATE OR REPLACE FUNCTION get_collaboration()
RETURNS SETOF collaboration
LANGUAGE plpython3u
AS $$
    query = """
            SELECT org_name as org, venue_name as venue
            FROM (venues v
                 JOIN
                 board_game_events bge
                 ON v.venue_id = bge.venue_id) AS vbge
                 JOIN
                 organizers org
                 ON vbge.org_id = org.org_id
            GROUP BY org_name, venue_name;
            """
    
    res = plpy.execute(query)
    
    return ([row for row in res])
$$

SELECT *
FROM get_collaboration();
                 