-- хранимая процедура CLR
-- изменить организатора игротеки

CREATE OR REPLACE PROCEDURE new_event_org(event_arg UUID, org_name_arg text)
LANGUAGE plpython3u
AS $$
    plan = plpy.prepare(
               """
               UPDATE board_game_events
               SET org_id = (SELECT org_id
                             FROM organizers
                             WHERE org_name = $1)
               WHERE event_id = $2;
               """, ["TEXT", "UUID"]
           )
    
    plpy.execute(plan, [org_name_arg, event_arg])
$$

CALL new_event_org('9a38c690-d6d5-45d4-9dfd-f378cc470baf', 'Alvarado Ltd')


-- вспомогательные
SELECT *
FROM board_game_events
WHERE org_id = (SELECT org_id
                FROM organizers
                WHERE org_name = 'Alvarado Ltd');

SELECT *
FROM board_game_events;

SELECT *
FROM organizers;
