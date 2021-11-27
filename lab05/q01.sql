-- извлечение данных в JSON

CREATE OR REPLACE PROCEDURE backup()
LANGUAGE plpgsql
AS $$
DECLARE
    t text;
    query TEXT;
BEGIN
    FOR t IN
        SELECT table_name
        FROM information_schema."tables"
        WHERE table_schema = 'public'
    LOOP
        query := 'COPY (SELECT row_to_json(r) FROM ' || t ||
                 ' AS r) TO ''/var/lib/postgres/data/' || t ||
                 '.json''';
        RAISE NOTICE '%', query;
        EXECUTE query;
    END LOOP;
END
$$

CALL backup();

SELECT *
FROM information_schema."tables";

COPY (SELECT row_to_json(r) FROM game_event r)
to '/var/lib/postgres/data/ge.json'