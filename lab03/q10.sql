-- триггер instead of
-- при вставке места проведения не соответствующего
-- типа, его замена на тип 'other'

CREATE OR REPLACE FUNCTION correct_type()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    venue_types TEXT[] := array[
             'anti-cafe',
             'apartment',
             'studio',
             'fast food restaurant',
             'hall',
             'rent',
             'other'];
    venue_type TEXT;
BEGIN
    venue_type := NEW.vanue_type;

    IF array_position(venue_types, venue_type) IS NULL
    THEN
        venue_type := 'other';
    END IF;

    INSERT INTO venues (venue_name, vanue_type, city, phone, site, email)
    VALUES (NEW.venue_name, venue_type, NEW.city, NEW.phone, NEW.site, NEW.email);

    RETURN NEW;
END
$$

CREATE OR REPLACE VIEW venue_view AS
SELECT *
FROM venues;

CREATE TRIGGER insert_correct_type
INSTEAD OF INSERT ON venue_view
FOR ROW EXECUTE PROCEDURE correct_type();

INSERT INTO venue_view (venue_name, vanue_type, city, phone, site, email)
VALUES ('Owl-cafe', 'cafe', 'Orel', '+79084568765', 'https://owlcafe.ru', 'help@owlcafe.org')


-- вспомогательные
DROP TRIGGER insert_correct_type ON venue_view;

DELETE FROM venues
WHERE venue_name = 'Owl-cafe';

SELECT *
FROM venue_view
WHERE venue_name = 'Owl-cafe';