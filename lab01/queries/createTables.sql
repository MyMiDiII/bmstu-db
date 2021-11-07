CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS board_games (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    producer TEXT,
    publicationYear INT CHECK (publicationYear >= 0),
    price INT CHECK (price >= 0) NOT NULL,
    minAge INT CHECK (minAge >= 0 AND minAge <= 125) DEFAULT 0 NOT NULL,
    maxAge INT CHECK (maxAge >= 0 AND maxAge <= 125) DEFAULT 125 NOT NULL,
    minPlayersNum INT CHECK (minPlayersNum > 0) DEFAULT 1 NOT NULL,
    maxPlayersNum INT CHECK (maxPlayersNum > 0),
    minPlayingTime INT CHECK (minPlayingTime > 0),
    maxPlayingTime INT CHECK (maxPlayingTIme > 0),
    CHECK (minAge <= maxAge),
    CHECK (minPlayersNum <= maxPlayersNum),
    CHECK (minPlayingTime <= maxPlayingTime)
);

CREATE TABLE IF NOT EXISTS venues (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    vanueType TEXT NOT NULL,
    city TEXT NOT NULL,
    phone TEXT,
    site TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS organizers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    city TEXT NOT NULL,
    foundingYear INT CHECK (foundingYear >= 0),
    phone TEXT,
    site TEXT,
    email TEXT
);

CREATE TABLE IF NOT EXISTS board_game_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    venueID UUID NOT NULL,
    organizerID UUID NOT NULL,
    title TEXT NOT NULL,
    eventDate DATE NOT NULL,
    startTime TIME,
    duration INT CHECK (duration BETWEEN 1 AND 24),
    playersNum INT CHECK (playersNum >= 0) DEFAULT 0 NOT NULL,
    purchase BOOLEAN NOT NULL,
    FOREIGN KEY (venueID) REFERENCES venues(id),
    FOREIGN KEY (organizerID) REFERENCES organizers(id)
);

CREATE TABLE IF NOT EXISTS game_event (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    eventID UUID,
    gameID UUID,
    FOREIGN KEY (eventID) REFERENCES board_game_events(id),
    FOREIGN KEY (gameID) REFERENCES board_games(id)
);