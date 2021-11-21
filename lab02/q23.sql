-- рекурсивное обобщенное табличное выражение
-- все организаторы, напрямую связанные с
-- крупными организаторами, то есть level = 1

WITH RECURSIVE co_organizers (org_id, org_name, parent_org, lvl) AS
(
    SELECT org_id, org_name, parent_org, 0 AS lvl
    FROM organizers o
    WHERE parent_org IS NULL
    UNION ALL
    SELECT o.org_id, o.org_name, o.parent_org, lvl + 1
    FROM organizers o JOIN co_organizers AS co
         ON o.parent_org = co.org_id
)
SELECT *
FROM co_organizers
WHERE lvl = 1;