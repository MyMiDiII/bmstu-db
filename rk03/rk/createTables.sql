-- Маслова Марина ИУ7-53Б
-- Вариант №3
-- Задание 1

-- создание таблиц

CREATE TABLE IF NOT EXISTS emps (
    id SERIAL PRIMARY KEY,
    fio TEXT,
    birthday date,
    dep TEXT
)

DROP TABLE emps;

CREATE TABLE IF NOT EXISTS in_out (
    io_id SERIAL PRIMARY KEY,
    emp_id INT NOT NULL,
    dt DATE NOT NULL,
    wday TEXT NOT NULL,
    tm TIME NOT NULL,
    type12 INT CHECK (type12 > 0 AND type12 < 3),
    FOREIGN KEY (emp_id) REFERENCES emps(id) ON DELETE CASCADE
);

DELETE FROM in_out *;

DROP TABLE in_out;

INSERT INTO emps (fio, birthday, dep) VALUES
('Иванов Иван Иванович', '1990-09-25', 'ИТ'),
('Петров Петр Петрович', '1987-11-12', 'Бухгалтерия'),
('Маслова Марина Дмитриевна', '2001-06-21', 'ИТ')

INSERT INTO emps (fio, birthday, dep) VALUES
('Иванов Иван Иванович', '2001-09-25', 'Бухгалтерия')

SELECT * FROM emps;

INSERT INTO in_out (emp_id, dt, wday, tm, type12) VALUES
(1, '2021-12-14', 'Вторник', '9:05:00', 1),
(1, '2021-12-14', 'Вторник', '9:20:00', 2),
(1, '2021-12-14', 'Вторник', '9:20:00', 2),
(1, '2021-12-14', 'Вторник', '9:20:00', 2),
(1, '2021-12-14', 'Вторник', '9:20:00', 2),
(1, '2021-12-14', 'Вторник', '9:25:00', 1),
(2, '2021-12-14', 'Вторник', '9:36:00', 1),
(2, '2021-12-14', 'Вторник', '18:36:00', 2),
(2, '2021-12-15', 'Среда',   '9:05:00', 1),
(2, '2021-12-15', 'Среда',   '17:10:00', 2),
(3, '2021-12-18', 'Суббота', '10:00:00', 1)

INSERT INTO in_out (emp_id, dt, wday, tm, type12) VALUES
(1, '2021-12-14', 'Вторник', '9:20:00', 2),
(1, '2021-12-14', 'Вторник', '9:20:00', 2),
(1, '2021-12-14', 'Вторник', '9:20:00', 2),
(1, '2021-12-14', 'Вторник', '9:20:00', 2)

SELECT * FROM in_out;
