-- IN + вложенный подзапрос
-- получить список игротек, проведенных
-- в портах

SELECT title, event_date
FROM board_game_events
WHERE venue_id IN (
    SELECT venue_id
    FROM venues
    WHERE city LIKE 'Port %'
);