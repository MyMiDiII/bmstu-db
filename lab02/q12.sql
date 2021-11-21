-- select + вложенные коррелированные подзапросы
-- выбрать все места проведения,
-- в которых не проводились игротеки

SELECT venue_name, vanue_type
FROM venues v
WHERE NOT EXISTS
    (SELECT *
     FROM board_game_events bge
     WHERE bge.venue_id = v.venue_id);

-- вспомогательный
SELECT DISTINCT venue_id
FROM board_game_events;