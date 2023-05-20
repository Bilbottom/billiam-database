
SELECT td.*
FROM presentation.task_details AS td
    NATURAL INNER JOIN (
        SELECT task, MAX(start_time) AS start_time
        FROM presentation.task_details
        WHERE group_id = 0
        GROUP BY task
    )
WHERE td.group_id = 0
ORDER BY td.task
