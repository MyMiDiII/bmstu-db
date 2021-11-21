-- скалярные подзапросы в выражениях столбцов
-- получить среднюю продолжительность игротек,
-- и максимальное число участников в одной игротеке
-- для каждого огранизатора

SELECT org_name,
       ( SELECT round(avg(duration))
         FROM board_game_events
         WHERE board_game_events.org_id = organizers.org_id
       ) AS avg_duration,
       ( SELECT max(players_num)
         FROM board_game_events
         WHERE board_game_events.org_id = organizers.org_id
       ) AS max_players_num
FROM organizers;