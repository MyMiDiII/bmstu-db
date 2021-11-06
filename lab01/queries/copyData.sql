COPY board_games
FROM '/var/lib/postgres/data/board_games.csv'
DELIMITER ',' CSV;

SELECT producer AS "Производитель", count(*) AS "Число игр"
FROM board_games bg
GROUP BY producer 
ORDER BY producer;