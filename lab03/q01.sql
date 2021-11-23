-- скалярная функция,
-- возвращающая среднюю продолжительность
-- игротек по id места проведения,
-- переданного в качестве параметра

CREATE OR REPLACE FUNCTION avg_venue_duration(id UUID)
RETURNS int
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (SELECT avg(duration) AS avgDur
            FROM board_game_events
            WHERE venue_id = id
           );
END
$$;

SELECT avg_venue_duration
FROM avg_venue_duration('0b693d99-d6ba-45d8-9b6e-5e58b02f1c05');