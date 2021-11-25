-- скалярная функция CLR
-- возвращает среднюю продолжительность

CREATE OR REPLACE FUNCTION get_avg2(min_dur int, max_dur int)
RETURNS INT
LANGUAGE plpython3u
AS $$
    return int((min_dur + max_dur) / 2)
$$

SELECT title, min_playing_time, max_playing_time,
       get_avg2(min_playing_time, max_playing_time)
FROM board_games;