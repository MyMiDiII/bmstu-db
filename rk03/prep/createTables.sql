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
('Петров Петр Петрович', '1987-11-12', 'Бухгалтерия')

SELECT * FROM emps;

INSERT INTO in_out (emp_id, dt, wday, tm, type12) VALUES
(1, '2018-12-14', 'Суббота', '9:05:00', 1),
(1, '2018-12-14', 'Суббота', '9:20:00', 2),
(1, '2018-12-14', 'Суббота', '9:25:00', 1),
(2, '2018-12-14', 'Суббота', '9:10:00', 1),
(2, '2018-12-14', 'Суббота', '18:36:00', 2),
(2, '2018-12-15', 'Воскресенье', '9:05:00', 1),
(2, '2018-12-15', 'Воскресенье', '17:10:00', 2)

SELECT * FROM in_out;
