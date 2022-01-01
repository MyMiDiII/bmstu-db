SELECT DISTINCT emps.id, fio, birthday
FROM emps
     JOIN
     in_out
     ON emps.id = in_out.emp_id
WHERE dep = 'Бухгалтерия' AND
      birthday = (
                  SELECT MIN(birthday)
                  FROM emps
                  WHERE dep = 'Бухгалтерия'
                 )
                 
SELECT emp_id, dt, count(*) AS out_num
FROM in_out
WHERE type12 = 2
GROUP BY emp_id, dt
HAVING count(*) > 4; -- три раза вышел и 1 раз ушел

SELECT emps.id, fio
FROM emps
     JOIN
     in_out
     ON emps.id = in_out.emp_id
WHERE dt = current_date AND type12 = 1 AND
      tm = (
            SELECT max(tm)
            FROM in_out
            WHERE type12 = 1 AND
                  dt = current_date
           )




