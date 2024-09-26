model (
    name seeds.work_absences,
    kind seed (
      path 'data/work_absences.csv',
    ),
    grain (absence_date),
    tags (daily-tracker),
    columns (
      absence_date date,
      absence_reason varchar,
      hours decimal(4, 2),
    ),
);
