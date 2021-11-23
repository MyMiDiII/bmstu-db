-- триггер after
-- обновление количества игр
-- при вставке в game_event

CREATE OR REPLACE FUNCTION update_games_num()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE board_game_events
    SET games_num = games_num + 1
    WHERE board_game_events.event_id = NEW.event_id;

    RETURN NEW;
END
$$

CREATE TRIGGER new_event_game
AFTER INSERT ON game_event
FOR ROW EXECUTE PROCEDURE update_games_num();

INSERT INTO game_event (event_id, game_id)
VALUES
('edf2acde-f147-47bb-9243-929c5ff9e05d', '65cf967a-83ed-4a29-9576-58df73b7cf8f')




-- вспомогательные
SELECT * FROM board_game_events WHERE event_id = 'edf2acde-f147-47bb-9243-929c5ff9e05d';

SELECT * FROM game_event WHERE event_id = 'edf2acde-f147-47bb-9243-929c5ff9e05d';

DROP TRIGGER IF EXISTS new_event_game ON game_event;
DROP FUNCTION IF EXISTS update_games_num;

DELETE FROM game_event
WHERE event_id = 'edf2acde-f147-47bb-9243-929c5ff9e05d';

UPDATE board_game_events
SET games_num = 0
WHERE event_id = 'edf2acde-f147-47bb-9243-929c5ff9e05d';

SELECT * FROM board_games WHERE title = 'Munchkin';