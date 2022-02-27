CREATE TABLE IF NOT EXISTS empl_visits (
    id SERIAL PRIMARY KEY,
    dep TEXT NOT NULL,
    fio TEXT NOT NULL,
    whendate DATE NOT NULL,
    status TEXT NOT NULL
);

INSERT INTO empl_visits (dep, fio, whendate, status)
VALUES
('ИТ','Иванов Иван Иванович','2021-01-15','Больничный'),
('ИТ','Иванов Иван Иванович','2021-01-16','На работе'),
('ИТ','Иванов Иван Иванович','2021-01-17','На работе'),
('ИТ','Иванов Иван Иванович','2021-01-18','На работе'),
('ИТ','Иванов Иван Иванович','2021-01-19','Оплачиваемый отпуск'),
('ИТ','Иванов Иван Иванович','2021-01-20','Оплачиваемый отпуск'),
('Бухгалтерия','Петрова Ирина Ивановна','2021-01-15','Оплачиваемый отпуск'),
('Бухгалтерия','Петрова Ирина Ивановна','2021-01-16','На работе'),
('Бухгалтерия','Петрова Ирина Ивановна','2021-01-17','На работе'),
('Бухгалтерия','Петрова Ирина Ивановна','2021-01-18','На работе'),
('Бухгалтерия','Петрова Ирина Ивановна','2021-01-19','Оплачиваемый отпуск'),
('Бухгалтерия','Петрова Ирина Ивановна','2021-01-20','Оплачиваемый отпуск');

WITH grps (id, dep, fio, whendate, status, grpdate) AS (
    SELECT id, dep, fio, whendate, status,
           whendate - (ROW_NUMBER() OVER
           (PARTITION BY dep, fio, status ORDER BY whendate))::int AS grpdate
    FROM empl_visits
)
SELECT dep, fio, min(whendate) AS date_from, max(whendate) AS date_to, status
FROM grps
GROUP BY dep, fio, status, grpdate
ORDER BY fio, date_from;

-- вложенный запрос
SELECT id, dep, fio, whendate, status,
       whendate - (ROW_NUMBER() OVER (PARTITION BY dep, fio, status ORDER BY whendate))::int AS grpdate
FROM empl_visits;

-- вспомогательные запросы
SELECT *
FROM empl_visits;

SELECT dep, fio, min(whendate) AS date_from, max(whendate) AS date_to, status
FROM empl_visits
GROUP BY dep, fio, status
ORDER BY fio, date_from;

-- для тестирования
INSERT INTO empl_visits (dep, fio, whendate, status)
VALUES
('Охрана','Иванов Иван Иванович','0001-01-01','Больничный');

DELETE FROM empl_visits
WHERE dep = 'Охрана';