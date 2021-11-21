-- UPDATE
-- уменьшить цены игр на 30%, которые
-- были выпущены 5 лет назад

UPDATE board_games
SET price = price * 0.7
WHERE publication_year = '2016';

-- вспомогательный
SELECT price
FROM board_games
WHERE publication_year = '2016'
ORDER BY price;

