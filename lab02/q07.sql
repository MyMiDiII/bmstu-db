-- агрегатные функции в выражениях столбцов
-- получить количество игротек, на которых можно купить игры

SELECT count(*)
FROM board_game_events
WHERE purchase;