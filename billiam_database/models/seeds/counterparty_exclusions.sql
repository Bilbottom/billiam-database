model (
    name seeds.counterparty_exclusions,
    kind seed (
      path 'data/counterparty_exclusions.csv',
    ),
    grain (counterparty),
    tags (finances),
    columns (
      counterparty varchar,
    ),
);
