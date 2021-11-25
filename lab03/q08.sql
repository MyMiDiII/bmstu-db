-- хранимая процедура доступа к метаданным
-- вывести все атрибуты и их типы таблицы,
-- имя которой задано параметром

CREATE OR REPLACE PROCEDURE show_table_attr(table_n VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    col_name varchar;
    col_type varchar;
BEGIN
    RAISE NOTICE 'Table % has following attributes:', table_n;

    FOR col_name, col_type IN 
        SELECT column_name, data_type 
        FROM information_schema."columns"
        WHERE table_name = table_n
    LOOP
        RAISE NOTICE '% of % type', col_name, col_type;
    END LOOP;
END
$$

CALL show_table_attr('board_game_events');