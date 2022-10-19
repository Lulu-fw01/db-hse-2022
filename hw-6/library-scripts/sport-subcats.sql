WITH RECURSIVE subcats (cat_name, parent_name) AS (
                   SELECT first_cat.name, first_cat.parent_category
                   FROM categories first_cat
                   WHERE first_cat.name = 'Спорт'
                   UNION ALL
                   SELECT next_cat.name, next_cat.parent_category
                   FROM categories next_cat
                            JOIN subcats sc ON sc.cat_name = next_cat.parent_category)
SELECT cat_name
FROM subcats