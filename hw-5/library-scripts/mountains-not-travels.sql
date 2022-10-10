SELECT b.isbn
FROM books b
WHERE 'Горы' IN (SELECT category_name FROM books_categories WHERE book_isbn = b.isbn)
  AND 'Путешествия' NOT IN (SELECT category_name FROM books_categories WHERE book_isbn = b.isbn)
