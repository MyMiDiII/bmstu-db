CREATE TABLE IF NOT EXISTS table1 (
    id int,
    var1 varchar,
    valid_from_dttm date,
    valid_to_dttm date
)

CREATE TABLE IF NOT EXISTS table2 (
    id int,
    var2 varchar,
    valid_from_dttm date,
    valid_to_dttm date
)

INSERT INTO table1 (id, var1, valid_from_dttm, valid_to_dttm)
VALUES (1,'A','2018-09-01','2018-09-15'),
       (1,'B','2018-09-16','5999-12-31')

INSERT INTO table2 (id, var2, valid_from_dttm, valid_to_dttm)
VALUES (1,'A','2018-09-01','2018-09-18'),
       (1,'B','2018-09-19','5999-12-31')
       
SELECT *
FROM table1;

SELECT *
FROM table1;
       

SELECT t1.id, var1, var2,
       GREATEST(t1.valid_from_dttm, t2.valid_from_dttm)
       AS valid_from_dttm,
       LEAST(t1.valid_to_dttm, t2.valid_to_dttm)
       AS valid_to_dttm
FROM table1 t1
     JOIN
     table2 t2
     ON t1.id = t2.id
WHERE t1.valid_from_dttm <= t2.valid_to_dttm
      AND t2.valid_from_dttm <= t1.valid_to_dttm;
