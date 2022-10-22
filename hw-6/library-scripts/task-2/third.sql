UPDATE rented_books
SET return_date = return_date + 30
WHERE 'Базы данных' IN (SELECT category_name FROM books_categories WHERE books_categories.book_isbn = isbn)
  AND return_date >= '2016-01-01'