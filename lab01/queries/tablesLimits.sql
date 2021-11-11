ALTER TABLE board_games
ALTER COLUMN game_id SET DEFAULT uuid_generate_v4(),
ALTER COLUMN title SET NOT NULL,
ALTER COLUMN price SET NOT NULL,
ALTER COLUMN min_age SET NOT NULL,
ALTER COLUMN max_age SET NOT NULL,
ALTER COLUMN min_players_num SET NOT NULL,
ALTER COLUMN min_age SET DEFAULT 0,
ALTER COLUMN max_age SET DEFAULT 125,
ALTER COLUMN min_players_num SET DEFAULT 1,
ADD CHECK (publication_year >= 0),
ADD CHECK (price >= 0),
ADD CHECK (min_age >= 0 AND min_age <= 125),
ADD CHECK (max_age >= 0 AND max_age <= 125),
ADD CHECK (min_players_num > 0),
ADD CHECK (max_players_num > 0),
ADD CHECK (min_playing_time > 0),
ADD CHECK (max_playing_time > 0),
ADD CHECK (min_age <= max_age),
ADD CHECK (min_players_num <= max_players_num),
ADD CHECK (min_playing_time <= max_playing_time);

ALTER TABLE venues
ALTER COLUMN venue_id SET DEFAULT uuid_generate_v4(),
ALTER COLUMN venue_name SET NOT NULL,
ALTER COLUMN vanue_type SET NOT NULL,
ALTER COLUMN city SET NOT NULL;

ALTER TABLE organizers
ALTER COLUMN org_id SET DEFAULT uuid_generate_v4(),
ALTER COLUMN org_name SET NOT NULL,
ALTER COLUMN city SET NOT NULL,
ADD CHECK (founding_year >= 0);

ALTER TABLE board_game_events
ALTER COLUMN event_id SET DEFAULT uuid_generate_v4(),
ALTER COLUMN venue_id SET NOT NULL,
ALTER COLUMN org_id SET NOT NULL,
ALTER COLUMN title SET NOT NULL,
ALTER COLUMN event_date SET NOT NULL,
ALTER COLUMN players_num SET NOT NULL,
ALTER COLUMN purchase SET NOT NULL,
ALTER COLUMN players_num SET NOT NULL,
ALTER COLUMN games_num SET NOT NULL,
ALTER COLUMN players_num SET DEFAULT 0,
ALTER COLUMN games_num SET DEFAULT 0,
ADD CHECK (players_num >= 0),
ADD CHECK (duration BETWEEN 1 AND 24),
ADD FOREIGN KEY (venue_id) REFERENCES venues(venue_id),
ADD FOREIGN KEY (org_id) REFERENCES organizers(org_id);

ALTER TABLE game_event
ALTER COLUMN ge_id SET DEFAULT uuid_generate_v4(),
ADD FOREIGN KEY (event_id) REFERENCES board_game_events(event_id),
ADD FOREIGN KEY (game_id) REFERENCES board_games(game_id);