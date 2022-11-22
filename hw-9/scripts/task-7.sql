select project,
commits,
contributors,
regexp_replace(address, '[[:digit:]]', '!', 'g') as address
FROM repositories