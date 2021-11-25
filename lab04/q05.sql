-- триггер CLR
-- сообщает о юбилейных игротеках организатора,
-- игротека которога была вставлена в таблицу

CREATE OR REPLACE FUNCTION jubilee_greeting()
RETURNS TRIGGER
LANGUAGE plpython3u
AS $$
    plan = plpy.prepare(
            """
            SELECT count(*) AS events_num
            FROM board_game_events
            WHERE org_id = $1
            """,
            ['UUID']
           )
           
    events_num = plpy.execute(plan, [TD['new']['org_id']])[0]['events_num']
    
    plan = plpy.prepare(
            """
            SELECT org_name 
            FROM organizers
            WHERE org_id = $1
            """,
            ['UUID']
           )

    org_name = plpy.execute(plan, [TD['new']['org_id']])[0]['org_name']
    
    if events_num % 5:
        plpy.notice(f'{org_name} has {events_num} board game events!')
    else:
        plpy.notice(f'Jubilee {events_num}th event! Congratulations to {org_name}!')
$$

CREATE TRIGGER jubilee
AFTER INSERT ON board_game_events
FOR ROW EXECUTE PROCEDURE jubilee_greeting();

INSERT INTO board_game_events
VALUES (DEFAULT, 'e044b6fa-0be6-46f9-9067-5e9ca265f96b', 'abeba2d6-e67a-429d-ab50-f32c221a4589',
        'Big Game!', '2021-12-31', '12:00:00', 15, DEFAULT, DEFAULT, TRUE);


-- вспомогательные
SELECT org_id, count(*) AS num FROM board_game_events
GROUP BY org_id;

SELECT * FROM board_game_events;

DROP TRIGGER jubilee ON board_game_events;

DELETE FROM board_game_events
WHERE title = 'Big Game!';











