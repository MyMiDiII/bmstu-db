CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS board_games (
    game_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    producer TEXT,
    publication_year INT CHECK (publication_year >= 0),
    price INT CHECK (price >= 0) NOT NULL,
    min_age INT CHECK (min_age >= 0 AND min_age <= 125) DEFAULT 0 NOT NULL,
    max_age INT CHECK (max_age >= 0 AND max_age <= 125) DEFAULT 125 NOT NULL,
    min_players_num INT CHECK (min_players_num > 0) DEFAULT 1 NOT NULL,
    max_players_num INT CHECK (max_players_num > 0),
    min_playing_time INT CHECK (min_playing_time > 0),
    max_playing_time INT CHECK (max_playing_time > 0),
    CHECK (min_age <= max_age),
    CHECK (min_players_num <= max_players_num),
    CHECK (min_playing_time <= max_playing_time)
);

CREATE TABLE IF NOT EXISTS venues (
    venue_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    venue_name TEXT NOT NULL,
    vanue_type TEXT NOT NULL,
    city TEXT NOT NULL,
    phone TEXT,
    site TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS organizers (
    org_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    org_name TEXT NOT NULL,
    city TEXT NOT NULL,
    founding_year INT CHECK (founding_year >= 0),
    phone TEXT,
    site TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS board_game_events (
    event_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    venue_id UUID NOT NULL,
    org_id UUID NOT NULL,
    title TEXT NOT NULL,
    event_date DATE NOT NULL,
    start_time TIME,
    duration INT CHECK (duration BETWEEN 1 AND 24),
    players_num INT CHECK (players_num >= 0) DEFAULT 0 NOT NULL,
    purchase BOOLEAN NOT NULL,
    FOREIGN KEY (venue_id) REFERENCES venues(venue_id),
    FOREIGN KEY (org_id) REFERENCES organizers(org_id)
);

CREATE TABLE IF NOT EXISTS game_event (
    ge_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    event_id UUID,
    game_id UUID,
    FOREIGN KEY (event_id) REFERENCES board_game_events(event_id),
    FOREIGN KEY (game_id) REFERENCES board_games(game_id)
);