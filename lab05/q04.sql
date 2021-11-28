-- 4
-- работа с json

-- 4.1
-- извлечь json фрагмент из json документа
-- выбор информации об активности игрока

SELECT info->'activity' AS activity
FROM players;


-- 4.2
-- извлечь значения кокретных узлов или атрибутов
-- вывод всех пар ник - игра

SELECT info->>'nickname' AS nick, p->>'game' AS game
FROM players
     CROSS JOIN
     LATERAL
     jsonb_array_elements(info->'activity') AS p;
     

-- 4.3
-- проверка на существование атрибута

CREATE OR REPLACE FUNCTION is_key(k TEXT, j JSONB)
RETURNS boolean
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN j->k IS NOT NULL;
END
$$

SELECT info->>'nickname' AS nick, is_key('fio', info) AS fio_key
FROM players;
 
SELECT info->>'nickname', is_key('activity', info) AS act_key
FROM players;


-- 4.4
-- изменить json документ
-- добавление/изменение fio игрока

UPDATE players
SET info = jsonb_set(info, '{fio}', '"hidden"', true)
WHERE info->>'nickname' = 'hamzreg'

SELECT info->>'nickname' AS nick, info->>'fio' AS fio
FROM players;


-- 4.5
-- разделить json на несколько строк по узлам

CREATE OR REPLACE FUNCTION get_player_struct(nick TEXT)
RETURNS TABLE
(
    nickname TEXT,
    jkey TEXT,
    jvalue TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT info->>'nickname', kv.*
        FROM players
             CROSS JOIN
             LATERAL
             jsonb_each_text(info) kv
        WHERE info->>'nickname' = nick;
END
$$

SELECT *
FROM get_player_struct('amunra2');