-- рекурсивная хранимая процедура
-- поиск всех руководителей заданного организатора

CREATE OR REPLACE PROCEDURE find_executives(org UUID)
LANGUAGE plpgsql
AS $$
DECLARE
    par UUID;
BEGIN
    SELECT parent_org
    INTO par
    FROM organizers
    WHERE org_id = org;

    IF par IS NULL THEN
        RAISE NOTICE '% is main!', org;
    ELSE
        CALL find_executives(par);
        RAISE NOTICE '% is suborg!', org;
    END IF;
END
$$

CALL find_executives('29f7b04a-8aa3-4093-b97a-6685838b3bde')

SELECT * FROM organizers;