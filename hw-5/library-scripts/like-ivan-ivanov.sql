SELECT DISTINCT r.name, r.surname
FROM readers r,
     rented_books rb
WHERE r.name != 'Иван'
  AND r.surname != 'Иванов'
  AND r.id = rb.reader_id
  AND rb.isbn IN
      (SELECT rb2.isbn
       FROM rented_books rb2,
            readers r2
       WHERE rb2.reader_id = r2.id
         AND r2.name = 'Иван'
         AND r2.surname = 'Иванов')