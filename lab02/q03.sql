-- LIKE
-- получить список организаторов, телефоны
-- которых имеют код России +7

SELECT org_name, email, phone
FROM organizers
WHERE phone LIKE '+7__________';