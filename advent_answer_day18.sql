WITH RECURSIVE HierarchyCTE AS (
    SELECT 
        staff_id,
        manager_id,
        staff_name,
        1 AS level
    FROM staff
    WHERE manager_id IS NULL
    UNION ALL
    SELECT 
        t.staff_id,
        t.manager_id,
        t.staff_name,
        h.level + 1
    FROM  staff t
    JOIN HierarchyCTE h ON t.manager_id = h.staff_id
)
SELECT 
   staff_id,
   staff_name,
   Level,
   COUNT(manager_id) OVER (PARTITION BY level) AS peers
FROM HierarchyCTE
ORDER BY peers DESC, level ASC, staff_id ASC;