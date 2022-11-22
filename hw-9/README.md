### task 1

```postgresql
SELECT (LENGTH(race) + bit_length(name)) as calculation
FROM demographics
```

### task 2

```postgresql
SELECT id, bit_length(name) as name, birthday, bit_length(race) as race
FROM demographics;
```

### task 3

```postgresql
SELECT id,
       ASCII(name) AS name,
       birthday,
       ASCII(race) AS race
FROM demographics
```

### task 4

```postgresql
SELECT format('%s %s %s %s', prefix, first, last, suffix) as title
FROM names
```

### task 5

```postgresql
select concat(md5, repeat('1', length(sha256) - length(md5)))   as md5,
       concat(repeat('0', length(sha256) - length(sha1)), sha1) as sha1,
       sha256
FROM encryption
```

### task 6

```postgresql
select left(project, commits)       as project,
       right(address, contributors) as address
FROM repositories
```

### task 7

```postgresql
select project,
       commits,
       contributors,
       regexp_replace(address, '[[:digit:]]', '!', 'g') as address
FROM repositories
```

### task 8

```postgresql
select name,
       weight,
       price,
       ROUND((price / (weight / 1000))::numeric, 2)::float AS price_per_kg
from products
order by price_per_kg
```