SELECT DISTINCT name, MAX(pages_num)
FROM books
group by name
