-- временная локальная таблица
-- все игротеки с контактами места проведения и организатора

SELECT event_id, title,
       venue_name, ve.phone AS venue_phone, ve.email AS venue_email,
       org_name, o.phone AS org_phone, o.email AS org_email
INTO TEMP contacts
FROM (venues v
      JOIN board_game_events bge
      ON v.venue_id = bge.venue_id) AS ve
      JOIN organizers o
      ON ve.org_id = o.org_id;
      
SELECT *
FROM contacts;