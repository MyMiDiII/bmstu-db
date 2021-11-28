-- Задание 3
-- Создать хранимую процедуру без параметров, которая
-- осуществляет поиск ключевого слова 'EXEC' в тексте
-- хранимых процедур в текущей базе данных.
-- Хранимая процедура выводит инструкцию 'EXEC',
-- которая выполняет хранимую процедуру или скалярную
-- пользовательскую функцию. Созданную хранимую процедуру
-- протестировать.

CREATE OR REPLACE PROCEDURE info_exec_proc()
LANGUAGE plpgsql
AS $$ 
DECLARE
    proc RECORD;
BEGIN
    RAISE NOTICE 'EXEC PROC LIST';
    FOR proc in
        SELECT routine_name, routine_type, routine_definition
        FROM information_schema.routines
        WHERE specific_schema = 'public'
              AND routine_type = 'PROCEDURE'
              AND routine_definition LIKE '%EXEC%'
    LOOP
        RAISE NOTICE '%', proc;
    END LOOP;
END
$$

CALL info_exec_proc();