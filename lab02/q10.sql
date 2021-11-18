-- поисковое выражение CASE
-- подпись типа игры по возрасту

SELECT title,
       CASE
           WHEN max_age <= 6 THEN 'для детей'
           WHEN min_age >= 7 AND max_age <= 12 THEN 'для школьников'
           WHEN min_age >= 12 AND max_age <= 18 THEN 'для подростков'
           WHEN min_age = 0 AND max_age >= 99 THEN 'для всех возрастов'
           WHEN max_age <= 25 THEN 'для мололежи'
           ELSE 'без типа'
       END
FROM board_games;