
FROM presentation.task_details
WHERE group_id = 0
QUALIFY ROW_NUMBER() OVER (PARTITION BY task ORDER BY start_time DESC) = 1
ORDER BY task
