SELECT parent_category
FROM categories
GROUP BY parent_category
HAVING COUNT(parent_category) >= 1