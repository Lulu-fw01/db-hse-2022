SELECT DISTINCT b.author, b.name
FROM books b,
     rented_books rb,
     readers r
WHERE r.name = 'Иван'
  AND r.surname = 'Иванов'
  AND r.id = rb.reader_id
  AND b.isbn = rb.isbn