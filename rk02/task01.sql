-- Маслова Марина ИУ7-53Б
-- Вариант № 4
-- Задание 1

CREATE TABLE IF NOT EXISTS parents
(
    id SERIAL PRIMARY KEY,
    fio varchar(100) NOT NULL,
    p_age int CHECK (p_age >= 0),
    p_type varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS children_group
(
    id SERIAL PRIMARY KEY,
    title varchar(20) NOT NULL,
    teacher_fio varchar(100) NOT NULL,
    max_hours_num int NOT NULL, CHECK (max_hours_num >= 0)
);

CREATE TABLE IF NOT EXISTS children
(
    id SERIAL PRIMARY KEY,
    fio varchar(100) NOT NULL,
    birthday date NOT NULL,
    gender varchar(10) NOT NULL,
    addres TEXT NOT NULL,
    ch_group INT,
    FOREIGN KEY (ch_group) REFERENCES children_group(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PC
(
    id SERIAL PRIMARY KEY,
    p_id INT,
    ch_id INT,
    FOREIGN KEY (p_id) REFERENCES parents(id) ON DELETE CASCADE,
    FOREIGN KEY (ch_id) REFERENCES children(id) ON DELETE CASCADE
);


INSERT INTO parents (fio, p_age, p_type)
VALUES
('Сергеев П. Д.',32,'папа'),
('Сергеева Г. К.',29,'мама'),
('Гусев А. Г.',40,'папа'),
('Сложнов К. Ш.',35,'законный представитель'),
('Широкова А. Э.',25,'мама'),
('Широков Н. В.',30,'папа'),
('Трунов К. Л.',43,'папа'),
('Лодина Г. П',50,'мама'),
('Маслов Д. В.',37,'папа'),
('Маслова И. Н.',42,'мама')

INSERT INTO children_group (title,teacher_fio, max_hours_num)
VALUES
('Солнышко','Рокотова А. К',6),
('Ручеек','Рокотова А. К.',8),
('Радуга','Кац Г. Л.',2),
('Знайки','Образцова Л. З.',12),
('Магнит','Косач Г. Д',3),
('Лодочка','Кац Г. Л',2),
('Зайчики',' Золотова Г. Ю.',8),
('Сони','Морфей Н. Ж.',7),
('Веселье','Уварова Г. В.',11),
('Золотце','Злат Ф. Р.',4)

INSERT INTO children (fio, birthday, gender, addres, ch_group)
VALUES
('Сергеев Н. П.','2016-12-16','м','ул. Соковая, д. 5',5),
('Сергеева Л. П.','2016-12-16','ж','ул. Соковая, д. 5',5),
('Гусев Г. А.','2016-12-16','м','ул. Маковая, д. 11',1),
('Лобач Г. К.','2017-12-16','ж','ул. Маковая, д. 56',2),
('Широков Н. Н.','2015-12-16','м','ул. Полевая, д. 113',9),
('Широкова М. Н.','2018-12-16','ж','ул. Полевая, д. 43',10),
('Широкова А. Н.','2018-12-16','м','ул. Русская, д. 8',10),
('Трунов Н. К.','2016-12-16','ж','ул. Пушкина, д. 1',8),
('Лодина К. Г.','2015-12-16','м','ул. Ленина, д. 3',8),
('Маслова М. Д.','2017-12-16','ж','ул. Маяковского, д. 13',3)


INSERT INTO PC (p_id, ch_id)
VALUES
(1,1),
(1,2),
(2,1),
(2,2),
(3,3),
(4,4),
(5,5),
(5,6),
(5,7),
(6,5),
(6,6),
(6,7),
(9,10),
(10, 10)
