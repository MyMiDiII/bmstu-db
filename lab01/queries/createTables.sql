CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS board_games (
    game_id UUID PRIMARY KEY,
    title TEXT,
    producer TEXT,
    publication_year INT,
    price INT,
    min_age INT,
    max_age INT,
    min_players_num INT,
    max_players_num INT,
    min_playing_time INT,
    max_playing_time INT
);

CREATE TABLE IF NOT EXISTS venues (
    venue_id UUID PRIMARY KEY,
    venue_name TEXT,
    vanue_type TEXT,
    city TEXT,
    phone TEXT,
    site TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS organizers (
    org_id UUID PRIMARY KEY,
    org_name TEXT,
    city TEXT,
    founding_year INT,
    phone TEXT,
    site TEXT,
    email TEXT,
    parent_org UUID REFERENCES organizers(org_id)
);

CREATE TABLE IF NOT EXISTS board_game_events (
    event_id UUID PRIMARY KEY,
    venue_id UUID,
    org_id UUID,
    title TEXT,
    event_date DATE,
    start_time TIME,
    duration INT,
    players_num INT,
    games_num INT,
    purchase BOOLEAN
);

CREATE TABLE IF NOT EXISTS game_event (
    ge_id UUID PRIMARY KEY,
    event_id UUID,
    game_id UUID
);