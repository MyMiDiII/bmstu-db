-- хранимая процедура с курсором
-- вывести контакты мест проведения каждой игротеки

CREATE OR REPLACE PROCEDURE get_venue_contacts()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    curs CURSOR FOR
        SELECT ROW_NUMBER() OVER() AS num, event_id, title,
        venue_name, phone, email
        FROM venues v
             JOIN board_game_events bge
             ON v.venue_id = bge.venue_id;
BEGIN
    OPEN curs;
    LOOP
        FETCH curs INTO rec;
        IF FOUND THEN
            RAISE NOTICE E'%. %\'s venue:
            name: %
            phone: %
            email: %',
                rec.num, rec.title, rec.venue_name,
                rec.phone, rec.email;
        END IF;
        EXIT WHEN NOT FOUND;
    END LOOP;
    CLOSE curs;
END
$$

CALL get_venue_contacts();