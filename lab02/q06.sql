-- сравнение с квантором
-- получить список игр, которые
-- дешевле всех игр для подростков (возраст 12-18)

SELECT title, price
FROM board_games
WHERE price < ALL (
    SELECT price
    FROM board_games
    WHERE min_age BETWEEN 12 AND 18
          AND max_age BETWEEN 12 AND 18
)
