Q1 = """
    SELECT DISTINCT id, fio, birthday
    FROM emps
    WHERE dep = 'Бухгалтерия' AND
          birthday = (
                      SELECT MIN(birthday)
                      FROM emps
                      WHERE dep = 'Бухгалтерия'
                     )
     """

# для каждой даты
# > 4 (три раза выходил и 1 раз ушел)
Q2 = """
     SELECT emp_id, dt, count(*) AS out_num
     FROM in_out
     WHERE type12 = 2
     GROUP BY emp_id, dt
     HAVING count(*) > 4;
     """

Q3 = """
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
     """
