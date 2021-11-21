-- предикат сравнения
-- выбрать названия, дату и продолжительность
-- игротек продолжительностью не больше 6 часов

SELECT title, event_date, duration
FROM board_game_events
WHERE duration <= 6;