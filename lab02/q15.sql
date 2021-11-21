-- group by с HAVING
-- получить список игр, в которые
-- на игротеках играли суммарно
-- более трех суток
-- (если игра была на игротеке, она игралась все время)

SELECT bg.title, sum(duration)
FROM (board_game_events bge
     JOIN game_event ge
     ON bge.event_id = ge.event_id) AS fge
     JOIN board_games bg
     ON bg.game_id = fge.game_id
GROUP BY bg.game_id
HAVING sum(duration) > 72;