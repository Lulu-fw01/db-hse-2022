SELECT name
FROM books
WHERE pages_num > 2 * (SELECT AVG(pages_num) FROM books)