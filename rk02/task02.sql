-- Задание 2

-- 1)
-- select + поисковое выражение case
-- получить информацию о положении семьи родителя
-- (многодетный, 2 детей, 1 ребенок, нет информации)

SELECT fio, p_age, p_type, count(*) AS ch_num,
       CASE
           WHEN count(*) > 2 THEN 'многодетый'
           WHEN count(*) = 2 THEN 'двое детей'
           WHEN count(*) = 1 THEN 'один ребенок'
           ELSE 'нет информации о детях'
       END
FROM parents p
     LEFT JOIN
     pc
     ON p.id = pc.p_id
GROUP BY fio, p_age, p_type;


-- 2)
-- update + скалярный подзапрос в SET
-- изменить максимальное число часов
-- более 10 на среднее по всем группам

UPDATE children_group
SET max_hours_num = (SELECT avg(max_hours_num)
                     FROM children_group)
WHERE max_hours_num > 10;

-- вспомогательный запрос
SELECT *
FROM children_group;


-- 3)
-- select + group by + having
-- получить id родителей
-- дети которых в среднем могут
-- проводить в группе более 4 часов

SELECT p_id, avg(mhn)
FROM (SELECT c.id AS gr_id, cg.max_hours_num AS mhn
      FROM children_group cg
      JOIN
      children c
      ON cg.id = c.ch_group) AS cgc
      JOIN
      pc
      ON cgc.gr_id = pc.ch_id
GROUP BY p_id
HAVING avg(mhn) > 4; 
     



