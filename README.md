# [Who has the most peers?](https://adventofsql.com/challenges/18)

## Description
Santa's workshop faces an organizational problem as Jingle, the Systems Administrator Elf, reveals that some departments have become inefficiently structured, with too many elves reporting to the same manager. Mrs. Claus calls this the "everyone reports to Bob" syndrome, which hurts both efficiency and manager wellbeing.

To address this, Santa decides to identify the most extreme case where multiple elves are clustered under one manager. He plans to write a query that will help find the employee with the most peers reporting to the same manager, shedding light on the overcrowded levels in the workshop's hierarchy. This will help address the organizational bottleneck and improve efficiency.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-18/blob/main/advent_of_sql_day_18.sql)

+ Write a query that finds the number of peers for the employee with the most peers. Peers are defined as employees who share both the same manager and the same level in the hierarchy.
+ Find the employee with the most peers and lowest level (e.g. smaller number). If there's more than 1 order by staff_id ascending.

## Dataset
This dataset contains 1 table. 
### Using PostgreSQL
**input**
```sql
SELECT *
FROM staff ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-18/blob/main/staff2.PNG)


### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-18/blob/main/advent_answer_day18.sql)

**input**
```sql

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

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-18/blob/main/d18.PNG)

