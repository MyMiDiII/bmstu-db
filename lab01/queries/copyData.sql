COPY board_games
FROM '/var/lib/postgres/data/csv/board_games.csv'
DELIMITER ',' CSV;

COPY venues
FROM '/var/lib/postgres/data/csv/venues.csv'
DELIMITER ',' CSV;

COPY organizers
FROM '/var/lib/postgres/data/csv/organizers.csv'
DELIMITER ',' CSV;

COPY board_game_events
FROM '/var/lib/postgres/data/csv/board_game_events.csv'
DELIMITER ',' CSV;

COPY game_event
FROM '/var/lib/postgres/data/csv/game_event.csv'
DELIMITER ',' CSV;