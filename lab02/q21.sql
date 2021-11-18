-- delete + вложенные коррелированные подзапросы
-- удалить места типа other,
-- в которых не было игротек

DELETE FROM venues v
WHERE vanue_type = 'other'
      AND NOT EXISTS
         (SELECT *
          FROM board_game_events bge
          WHERE bge.venue_id = v.venue_id);

-- вспомогательный
SELECT venue_name, vanue_type
FROM venues v
WHERE vanue_type = 'other' AND NOT EXISTS
    (SELECT *
     FROM board_game_events bge
     WHERE bge.venue_id = v.venue_id);