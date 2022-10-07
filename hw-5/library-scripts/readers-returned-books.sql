SELECT DISTINCT r.name, r.surname
FROM readers r, rented_books rb
WHERE rb.return_date < CURRENT_DATE
AND rb.reader_id = r.id