 -- BETWEEN
 -- получить список игр, ценой от 500 до 1200
 
 SELECT title, producer, price
 FROM board_games
 WHERE price BETWEEN 500 AND 1200;