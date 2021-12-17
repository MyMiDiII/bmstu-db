CREATE OR REPLACE FUNCTION fn_get_late_num(d date)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
   RETURN (SELECT count(*)
           FROM (SELECT emp_id
                 FROM in_out
                 WHERE dt = d AND type12 = 1
                 GROUP BY emp_id
                 HAVING min(tm) > '09:00:00') AS foo);
END
$$

SELECT *
FROM fn_get_late_num('2018-12-14');

-- test
SELECT count(*)
FROM (SELECT emp_id
      FROM in_out
      WHERE dt = '2018-12-15' AND type12 = 1
      GROUP BY emp_id
      HAVING min(tm) > '09:00:00') AS foo;
