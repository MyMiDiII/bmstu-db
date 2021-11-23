-- функция с рекурсивным ОТВ
-- возвращает всех организаторов
-- определенного уровня, заданного
-- параметром

CREATE OR REPLACE FUNCTION get_lev_coorgs(org_lvl INT)
RETURNS TABLE (
    rorg_id UUID,
    rorg_name TEXT,
    rparent_org UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
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
        SELECT org_id, org_name, parent_org
        FROM co_organizers
        WHERE lvl = org_lvl;
END
$$

SELECT *
FROM get_lev_coorgs(1);

SELECT *
FROM get_lev_coorgs(0);

-- вспомогательный
DROP FUNCTION get_lev_coorgs;