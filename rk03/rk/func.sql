-- функция, возвращающая минимальный
-- возраст сотрудника, опоздавшего
-- более чем на 10 минут

CREATE OR REPLACE FUNCTION fn_min_age_late10()
RETURNS int
LANGUAGE plpgsql
AS $$
BEGIN
   RETURN (SELECT min(date_part('year', now()) - date_part('year', birthday))
           FROM emps
                JOIN
                in_out
                ON emps.id = in_out.emp_id
           WHERE type12 = 1
           GROUP BY emp_id
           HAVING min(tm) - '09:00:00' > INTERVAL '10 minutes');
END
$$

DROP FUNCTION fn_min_age_late10;

SELECT *
FROM fn_min_age_late10() 
