SELECT name
FROM book_copies
         JOIN books b on b.isbn = book_copies.isbn
GROUP BY b.isbn
HAVING COUNT(b.isbn) > 1

