SELECT dep, count(*) AS late_num
FROM emps
     JOIN
     (
        SELECT emp_id
        FROM in_out
        WHERE type12 = 1
        GROUP BY emp_id
        HAVING min(tm) > '09:00:00'
     ) AS l
     ON emps.id = l.emp_id
GROUP BY dep;
