-- хранимая процедура с параметрами
-- делает заданную скидку (в %) на заданную игру

CREATE OR REPLACE PROCEDURE give_discount(game UUID, discount decimal)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE board_games
    SET price = price * (1 - discount / 100)
    WHERE game_id = game;
END
$$

CALL give_discount('a5c92b76-8870-46f6-b898-7c54e44a0e23', 10);

SELECT game_id, title, price
FROM board_games
WHERE game_id = 'a5c92b76-8870-46f6-b898-7c54e44a0e23';