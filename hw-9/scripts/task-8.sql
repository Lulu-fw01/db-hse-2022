select name,
       weight,
       price,
       ROUND((price / (weight / 1000))::numeric, 2)::float AS price_per_kg
from products
order by price_per_kg