SELECT author
FROM books
GROUP BY author
HAVING COUNT(author) > 5