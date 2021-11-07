# Настройки и использование

## Выполнение ЛР

### Через dbeaver

TODO

### Через командную строку

* Подключаемся к нашему пользователю:
```
$ psql -U mymidi
```
* Просматриваем список баз:
```
mymidi-# \l
```

* Запускаем скрипт создания нашей БД (путь к файлу от текущей директории):
```
mymidi-# \i queries/createDB.sql 
DROP DATABASE
CREATE DATABASE
```

* Просматриваем список баз, в нем должна появиться строка с именем нашей БД:
```
mymidi-# \l
                                    List of databases
      Name      |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   
----------------+----------+----------+-------------+-------------+-----------------------
 board_games_db | mymidi   | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
...
```

* Подключаемся к БД:
```
mymidi-# \c board_games_db 
You are now connected to database "board_games_db" as user "mymidi".
```

* Просматриваем список таблиц (сейчас в нем ничего нет):
```
board_games_db-# \d
Did not find any relations.
```

* Выполняем скрипт с запросами по созданию таблиц:
```
board_games_db-# \i queries/createTables.sql 
CREATE EXTENSION
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
```

* Теперь в базе есть таблицы:
```
board_games_db-# \d
              List of relations
 Schema |       Name        | Type  | Owner  
--------+-------------------+-------+--------
 public | board_game_events | table | mymidi
 public | board_games       | table | mymidi
 public | game_event        | table | mymidi
 public | organizers        | table | mymidi
 public | venues            | table | mymidi
(5 rows)
```

* Проверяем, что в таблицах ничего нет:
```
board_games_db=# select * from venues;
 venue_id | venue_name | vanue_type | city | phone | site | email 
----------+------------+------------+------+-------+------+-------
(0 rows)
```

* Производим массовое копирование данных, запуская соответсвующий скрипт:
```
board_games_db=# \i queries/copyData.sql 
COPY 3000
COPY 1000
COPY 1000
COPY 2000
COPY 6000
```

* Проверяем, что теперь в таблицах есть данные:
```
board_games_db=# select * from venues;
```
* Отключаемся и выходим 😊:
```
board_games_db=# \q
```
