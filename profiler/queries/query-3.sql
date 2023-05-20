
FROM presentation.task_details AS td
WHERE td.group_id = 0
  AND start_time = (
      SELECT MAX(inner_td.start_time)
      FROM presentation.task_details AS inner_td
      WHERE inner_td.group_id = 0
        AND inner_td.task = td.task
  )
ORDER BY td.task
