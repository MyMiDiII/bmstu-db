-- защита
-- процедура, удаляющая
-- все игротеки в заданном интервале дат

CREATE OR REPLACE PROCEDURE lockdown(b_date date, e_date date)
LANGUAGE plpgsql
AS $$
DECLARE
    event_arr uuid[];
BEGIN
    event_arr := ARRAY(
                     SELECT event_id
                     FROM board_game_events
                     WHERE event_date BETWEEN b_date AND e_date
                 );
    DELETE FROM game_event
    WHERE array_position(event_arr, event_id) IS NOT NULL;
             
    DELETE FROM board_game_events
    WHERE array_position(event_arr, event_id) IS NOT NULL;
END
$$

CALL lockdown('2021-11-01', '2021-11-10');

-- вспомогательные
SELECT *
FROM board_game_events
WHERE event_date BETWEEN '2021-11-01' AND '2021-11-10';

SELECT *
FROM game_event
WHERE event_id IN
(SELECT event_id
FROM board_game_events
WHERE event_date BETWEEN '2021-11-01' AND '2021-11-10');

-- для тестирования
CALL lockdown('1971-01-01', '1971-12-31');

SELECT *
FROM board_game_events
WHERE event_date BETWEEN '1971-01-01' AND '1971-12-31';

SELECT *
FROM game_event
WHERE event_id IN
(SELECT event_id
FROM board_game_events
WHERE event_date BETWEEN '1971-01-01' AND '1971-12-31');
