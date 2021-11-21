-- вложенные подзапросы с уровнем вложенности 3
-- получить информацию об игротеках, на которых
-- максимальная цена игры больше
-- максимальной средней цены игр на всех игротеках

SELECT *
FROM board_game_events bge
WHERE event_id IN
    (SELECT event_id
     FROM game_event ge
          JOIN 
          board_games bg
          ON ge.game_id = bg.game_id
     GROUP BY event_id
     HAVING max(price) > (SELECT max(avg_price)
                          FROM (SELECT avg(price) AS avg_price
                                FROM game_event ge JOIN board_games bg
                                ON ge.game_id = bg.game_id
                                GROUP BY event_id) AS avg_prices
                          )
    );
