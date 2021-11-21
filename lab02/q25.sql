-- устрание дублей с помощью row_number()

WITH producers AS (
    SELECT producer,
           ROW_NUMBER() OVER(PARTITION BY producer) AS num
    FROM board_games
    ORDER BY producer
)
SELECT producer
FROM producers
WHERE num = 1;